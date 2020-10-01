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
