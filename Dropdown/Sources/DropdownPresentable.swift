//
//  DropdownPresentable.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/2/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

public protocol DropdownPresentable {
    var isDraggingEnabled: Bool { get }
    var dismissAfterRelease: Bool { get }
    var dismissDraggingTranslationThreshold: CGFloat { get }
    var stretchableBackgroundColor: UIColor { get }
    
    var dismissAfterTappingDimmingView: Bool { get }
    
    var isFeedbackEnabled: Bool { get }
    var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle { get }
}

extension DropdownPresentable {
    var isDraggingEnabled: Bool { true }
    var dismissAfterRelease: Bool { true }
    var dismissDraggingTranslationThreshold: CGFloat { 150.0 }
    var stretchableBackgroundColor: UIColor { .white }
    
    var dismissAfterTappingDimmingView: Bool { true }
    
    var isFeedbackEnabled: Bool { true }
    var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle { .light }
}
