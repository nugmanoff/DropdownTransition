//
//  DropdownPresentable.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/2/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

public protocol DropdownPresentable {
    var dismissTranslationThreshold: CGFloat { get }
    var stretchableBackgroundColor: UIColor { get }
}
