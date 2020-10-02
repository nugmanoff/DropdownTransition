//
//  ChatFolderViewModel.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/1/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

struct ChatFolderViewModel {
    let image: UIImage?
    let imageBackgroundColor: UIColor
    let name: String
    let chatCount: Int
    let isAnnotationHidden: Bool
    
    init(image: UIImage?, imageBackgroundColor: UIColor, name: String, chatCount: Int, isAnnotationHidden: Bool = false) {
        self.image = image
        self.imageBackgroundColor = imageBackgroundColor
        self.name = name
        self.chatCount = chatCount
        self.isAnnotationHidden = isAnnotationHidden
    }
}

extension ChatFolderViewModel {
    static var `default`: [ChatFolderViewModel] = [
        .init(image: UIImage(named: "star"), imageBackgroundColor: UIColor(hexString: "#6ED352"), name: "Bookmarks", chatCount: 16),
        .init(image: UIImage(named: "users"), imageBackgroundColor: UIColor(hexString: "#EE6C3E"), name: "Personal Chats", chatCount: 7),
        .init(image: UIImage(named: "portfolio"), imageBackgroundColor: UIColor(hexString: "#3769EF"), name: "Work", chatCount: 5),
        .init(image: UIImage(named: "plus"), imageBackgroundColor: .clear, name: "Add new folder", chatCount: 0, isAnnotationHidden: true)
    ]
}
