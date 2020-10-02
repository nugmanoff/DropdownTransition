//
//  IntrinsicTableView.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/2/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

public final class IntrinsicTableView: UITableView {
    override public var intrinsicContentSize: CGSize {
        contentSize
    }

    override public var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
