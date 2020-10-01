//
//  ChatCell.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/1/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

final class ChatCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var isOnlineBadge: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var unreadCountLabel: UILabel!
    @IBOutlet private weak var unreadCountContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        isOnlineBadge.layer.cornerRadius = isOnlineBadge.bounds.height / 2
        isOnlineBadge.layer.borderWidth = 2
        isOnlineBadge.layer.borderColor = UIColor.white.cgColor
    }
    
    func configure(with viewModel: ChatViewModel) {
        avatarImageView.image = viewModel.image
        isOnlineBadge.isHidden = !viewModel.isOnline
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        dateLabel.text = viewModel.date
        if viewModel.unreadCount == 0 {
            unreadCountContainerView.isHidden = true
        } else {
            unreadCountContainerView.isHidden = false
            unreadCountLabel.text = "\(viewModel.unreadCount)"
        }
        
    }
}
