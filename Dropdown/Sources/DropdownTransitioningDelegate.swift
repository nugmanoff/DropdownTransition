//
//  DropdownTransitioningDelegate.swift
//  DPUIKit
//
//  Created by Aidar Nugmanov on 7/8/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

private enum Constants {
    static let navigationBarHeight: CGFloat = 44
    static let transitionDuration: TimeInterval = 0.45
}

public final class DropdownTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        DropdownPresentationController(presentedViewController: presented, presenting: presenting)
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DropdownPresentingAnimationController()
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DropdownDismissingAnimationController()
    }
}

final class DropdownPresentingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .to),
            let presentingViewController = transitionContext.viewController(forKey: .from),
            let toView = transitionContext.view(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        let navigationBarY: CGFloat = getStatusBarHeight() + Constants.navigationBarHeight
        let finalFrame = transitionContext.finalFrame(for: presentedViewController)
        let viewSize = CGSize(width: UIScreen.main.bounds.width, height: .leastNonzeroMagnitude)
        let size = toView.systemLayoutSizeFitting(viewSize,
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .defaultLow)
        containerView.addSubview(toView)
        if let navigationBar = (presentingViewController as? UINavigationController)?.navigationBar {
            containerView.addSubview(navigationBar)
        }
        toView.frame = CGRect(x: 0, y: containerView.frame.minY - size.height, width: finalFrame.width, height: size.height)
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                           toView.frame = CGRect(x: 0, y: navigationBarY, width: size.width, height: size.height)
                       }, completion: { finished in
                           transitionContext.completeTransition(finished)
        })
    }
}

final class DropdownDismissingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let presentedViewController = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        let finalFrame = CGRect(x: 0, y: containerView.frame.minY - fromView.bounds.height, width: fromView.bounds.width, height: fromView.bounds.height)
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        fromView.frame = finalFrame
                       }, completion: { finished in
                        fromView.removeFromSuperview()
                        if let navigationBar = (presentedViewController as? UINavigationController)?.navigationBar {
                            presentedViewController.view.addSubview(navigationBar)
                        }
                        transitionContext.completeTransition(finished)
        })
    }
}
