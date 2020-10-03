//
//  ChatFolderCell.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/1/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

final class ChatFolderCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var chevronImageView: UIImageView!
    @IBOutlet private weak var iconImageBackgroundView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var annotationLabel: UILabel!
    
    func configure(with viewModel: ChatFolderViewModel) {
        iconImageView.image = viewModel.image
        iconImageBackgroundView.backgroundColor = viewModel.imageBackgroundColor
        titleLabel.text = viewModel.name
        annotationLabel.text = "\(viewModel.chatCount) chats"
        chevronImageView.isHidden = viewModel.isAnnotationHidden
        annotationLabel.isHidden = viewModel.isAnnotationHidden
    }
}
