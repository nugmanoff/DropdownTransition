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
        .init(image: UIImage(named: "emma"), title: "Emma Watson", subtitle: "It is not Levios-a, it is Leviosa-r!", date: "07 Oct", unreadCount: 0, isOnline: false),
        .init(image: UIImage(named: "strange"), title: "Doctor Strange", subtitle: "What is the WiFi password?", date: "18 Aug", unreadCount: 6, isOnline: true),
        .init(image: UIImage(named: "jessie"), title: "Jessie Eisenberg", subtitle: "I suppose now you see me on Facetime", date: "21 Apr", unreadCount: 4, isOnline: true),
        .init(image: UIImage(named: "fury"), title: "Some Pirate", subtitle: "Are you in?", date: "05 Jun", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "jessica"), title: "Jessica Alba", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "03 Jul", unreadCount: 0, isOnline: true),
        .init(image: UIImage(named: "robert"), title: "Robert de Niro", subtitle: "Where is the Julia's office? ASAP", date: "10 Jun", unreadCount: 0, isOnline: false),
        
        .init(image: UIImage(named: "punisher"), title: "Frank", subtitle: "One batch, two batch, penny and dime", date: "03 Sep", unreadCount: 3, isOnline: true)
    ]
}
