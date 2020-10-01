//
//  DropdownPresentationController.swift
//  DPUIKit
//
//  Created by Aidar Nugmanoff on 7/8/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

private enum Constants {
    static let dimmingViewAlphaComponent: CGFloat = 0.4
    static let navigationBarHeight: CGFloat = 44
}

public protocol DropdownPresentable {
    var dismissTranslationThreshold: CGFloat { get }
    var stretchableBackgroundColor: UIColor { get }
}

final class DropdownPresentationController: UIPresentationController, UIGestureRecognizerDelegate {
    private var panGestureRecognizer: UIPanGestureRecognizer?
    // TODO: Заменить на FeedbackEmitter
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private var afterReleaseDismissing = false
    private var startDismissing = false

    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewDidTap)))
        view.backgroundColor = UIColor.black.withAlphaComponent(Constants.dimmingViewAlphaComponent)
        return view
    }()

    private lazy var backupView: UIView = {
        let view = UIView()
        let backgroundColor = (presentedViewController as? DropdownPresentable)?.stretchableBackgroundColor ?? .black
        view.backgroundColor = backgroundColor
        return view
    }()

    override var frameOfPresentedViewInContainerView: CGRect {
        let navigationBarY: CGFloat = getStatusBarHeight() + Constants.navigationBarHeight
        return CGRect(x: 0,
                      y: navigationBarY,
                      width: presentedViewController.preferredContentSize.width,
                      height: presentedViewController.preferredContentSize.height)
    }

    override func presentationTransitionWillBegin() {
        guard
            let containerView = containerView,
            let coordinator = presentingViewController.transitionCoordinator
        else { return }
        feedbackGenerator.prepare()
        let navigationBarY: CGFloat = getStatusBarHeight() + Constants.navigationBarHeight
        dimmingView.frame = CGRect(x: 0, y: navigationBarY, width: containerView.bounds.width, height: containerView.bounds.height - navigationBarY)
        containerView.addSubview(dimmingView)
        dimmingView.addSubview(presentedViewController.view)
        dimmingView.alpha = 0
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 1
        }, completion: nil)
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        guard let containerView = containerView else { return }
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGestureRecognizer?.delegate = self
        panGestureRecognizer?.maximumNumberOfTouches = 1
        panGestureRecognizer?.cancelsTouchesInView = false
        containerView.addGestureRecognizer(panGestureRecognizer!)
        backupView.frame = CGRect(x: 0, y: 0, width: frameOfPresentedViewInContainerView.width, height: 1)
        dimmingView.insertSubview(backupView, belowSubview: presentedViewController.view)
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func dismissalTransitionWillBegin() {
        guard
            let coordinator = presentingViewController.transitionCoordinator else { return }
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }
            self.dimmingView.alpha = 0
        }, completion: nil)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        guard completed else { return }
        dimmingView.removeFromSuperview()
    }

    @objc
    private func dimmingViewDidTap() {
        presentedViewController.dismiss(animated: true)
    }
}

extension DropdownPresentationController {
    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        guard
            gestureRecognizer.isEqual(panGestureRecognizer),
            let presentedView = presentedView,
            let containerView = containerView else { return }
        switch gestureRecognizer.state {
        case .began:
            presentingViewController.view.layer.removeAllAnimations()
            presentingViewController.view.endEditing(true)
            presentedViewController.view.endEditing(true)
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: containerView)
        case .changed:
            let translation = gestureRecognizer.translation(in: containerView).y
            updateForTranslation(inVerticalDirection: translation)
            if translation <= -Constants.navigationBarHeight {
                presentedViewController.dismiss(animated: true, completion: nil)
            }
        case .ended:
            let translation = gestureRecognizer.translation(in: containerView).y
            guard let dismissTranslationThreshold = (presentedViewController as? DropdownPresentable)?.dismissTranslationThreshold else { return }
            if translation >= dismissTranslationThreshold {
                presentedViewController.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.6,
                               delay: 0,
                               usingSpringWithDamping: 1,
                               initialSpringVelocity: 1,
                               options: [.curveEaseOut, .allowUserInteraction],
                               animations: {
                                   presentedView.transform = .identity
                                   self.backupView.transform = .identity
                })
            }
        default:
            break
        }
    }

    private func updateForTranslation(inVerticalDirection translation: CGFloat) {
        guard
            let presentedView = presentedView,
            !startDismissing,
            let dismissTranslationThreshold = (presentedViewController as? DropdownPresentable)?.dismissTranslationThreshold else { return }

        let elasticThreshold: CGFloat = 0
        let translationFactor: CGFloat = 1 / 2

        let translationForModal: CGFloat = {
            if translation >= elasticThreshold {
                let frictionLength = translation - elasticThreshold
                let frictionTranslation = 30 * atan(frictionLength / 120) + frictionLength / 10
                return frictionTranslation + (elasticThreshold * translationFactor)
            } else {
                return translation * translationFactor
            }
        }()

        if translation >= 0 {
            backupView.setAnchorPoint(.init(x: 0, y: 0))
            backupView.transform = CGAffineTransform(scaleX: 1, y: translationForModal)
        }

        presentedView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: translationForModal)

        let afterReleaseDismissing = (translation >= dismissTranslationThreshold)
        if afterReleaseDismissing != self.afterReleaseDismissing {
            self.afterReleaseDismissing = afterReleaseDismissing
            feedbackGenerator.impactOccurred()
        }
    }
}

public extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
