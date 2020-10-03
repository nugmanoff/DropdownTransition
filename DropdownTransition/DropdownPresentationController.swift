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

final class DropdownPresentationController: UIPresentationController, UIGestureRecognizerDelegate {
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var feedbackGenerator: UIImpactFeedbackGenerator?
    private var presentedDropdown: DropdownPresentable!
    private var dismissAfterReleaseState = false

    private lazy var dimmingView: UIView = {
        let view = UIView()
        let dismissAfterTappingDimmingView = (presentedViewController as? DropdownPresentable)?.dismissAfterTappingDimmingView ?? false
        if dismissAfterTappingDimmingView {
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewDidTap)))
        }
        view.backgroundColor = UIColor.black.withAlphaComponent(Constants.dimmingViewAlphaComponent)
        return view
    }()

    private lazy var backupView: UIView = {
        let view = UIView()
        let backgroundColor = (presentedViewController as? DropdownPresentable)?.stretchableBackgroundColor ?? .clear
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
            let coordinator = presentingViewController.transitionCoordinator,
            let presentedDropdown = presentedViewController as? DropdownPresentable
        else {
            assertionFailure("Conditions necessary for transition are not satisfied")
            return
        }
        self.presentedDropdown = presentedDropdown
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
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGestureRecognizer?.delegate = self
        panGestureRecognizer?.maximumNumberOfTouches = 1
        panGestureRecognizer?.cancelsTouchesInView = false
        if presentedDropdown.isDraggingEnabled {
            containerView?.addGestureRecognizer(panGestureRecognizer!)
        }
        if presentedDropdown.isFeedbackEnabled {
            feedbackGenerator = UIImpactFeedbackGenerator(style: presentedDropdown.feedbackStyle)
            feedbackGenerator?.prepare()
        }
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
            guard presentedDropdown.dismissAfterRelease else { return }
            if translation <= -presentedDropdown.dismissDraggingTranslationThreshold {
                presentedViewController.dismiss(animated: true, completion: nil)
            }
        case .ended:
            let translation = gestureRecognizer.translation(in: containerView).y
            guard presentedDropdown.dismissAfterRelease else {
                animatePresentedViewBackToPlace()
                return
            }
            if translation >= presentedDropdown.dismissDraggingTranslationThreshold {
                presentedViewController.dismiss(animated: true, completion: nil)
            } else {
                animatePresentedViewBackToPlace()
            }
        default:
            break
        }
    }
    
    private func animatePresentedViewBackToPlace() {
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                            self.presentedView?.transform = .identity
                            self.backupView.transform = .identity
        })
    }

    private func updateForTranslation(inVerticalDirection translation: CGFloat) {
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

        presentedView?.transform = CGAffineTransform.identity.translatedBy(x: 0, y: translationForModal)

        guard presentedDropdown.dismissAfterRelease else { return }
        
        let dismissAfterReleaseState = (translation >= presentedDropdown.dismissDraggingTranslationThreshold)
        if dismissAfterReleaseState != self.dismissAfterReleaseState {
            self.dismissAfterReleaseState = dismissAfterReleaseState
            feedbackGenerator?.impactOccurred()
        }
    }
}
