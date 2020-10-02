//
//  ChatViewModel.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/1/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

struct ChatViewModel {
    let image: UIImage?
    let title: String
    let subtitle: String
    let date: String
    let unreadCount: Int
    let isOnline: Bool
}

extension ChatViewModel {
    static var `default`: [ChatViewModel] = [
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 0, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "Emma Watson", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "07 Oct", unreadCount: 0, isOnline: false),
        .init(image: UIImage(named: "therock"), title: "", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "21 Apr", unreadCount: 4, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "03 Jul", unreadCount: 0, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "10 Jun", unreadCount: 0, isOnline: false),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "18 Aug", unreadCount: 6, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "03 Sep", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "05 Jun", unreadCount: 3, isOnline: true),
    ]
}
