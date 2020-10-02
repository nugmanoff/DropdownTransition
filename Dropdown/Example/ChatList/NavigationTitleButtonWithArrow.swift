//
//  NavigationTitleButtonWithArrow.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/2/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

final class NavigationTitleButtonWithArrow: UIButton {
    enum ArrowDirection {
        case up
        case down
        
        mutating func toggle() {
            switch self {
            case .up: self = .down
            case .down: self = .up
            }
        }
    }
    
    var title: String = ""
    private var arrowDirection: ArrowDirection = .down
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        semanticContentAttribute = .forceRightToLeft
        setTitle("Personal Chats", for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        setTitleColor(.black, for: .normal)
        let image = UIImage(systemName: "chevron.down")?
            .withConfiguration(UIImage.SymbolConfiguration(weight: .semibold))
            .withTintColor(UIColor(hexString: "#3769F0"))
        setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func toggleArrow() {
        let identity = CGAffineTransform.identity
        arrowDirection.toggle()
        switch arrowDirection {
        case .down:
            imageView?.transform = identity
        case .up:
            imageView?.transform = identity.rotated(by: 180.0 * .pi)
            imageView?.transform = identity.rotated(by: -.pi)
        }
    }
}
