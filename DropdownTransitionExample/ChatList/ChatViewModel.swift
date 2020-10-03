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
    static var storage: [String: [ChatViewModel]] = [
        "Personal Chats": [
            ChatViewModel(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 0, isOnline: true),
            ChatViewModel(image: UIImage(named: "emma"), title: "Emma Watson", subtitle: "It is not Levios-a, it is Leviosa-r!", date: "07 Oct", unreadCount: 0, isOnline: false),
            ChatViewModel(image: UIImage(named: "strange"), title: "Doctor Strange", subtitle: "What is the WiFi password?", date: "18 Aug", unreadCount: 6, isOnline: true),
            ChatViewModel(image: UIImage(named: "jessie"), title: "Jessie Eisenberg", subtitle: "I suppose now you see me on Facetime", date: "21 Apr", unreadCount: 4, isOnline: true),
            ChatViewModel(image: UIImage(named: "fury"), title: "Some Pirate", subtitle: "Are you in?", date: "05 Jun", unreadCount: 3, isOnline: true),
            ChatViewModel(image: UIImage(named: "jessica"), title: "Jessica Alba", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "03 Jul", unreadCount: 0, isOnline: true),
            ChatViewModel(image: UIImage(named: "robert"), title: "Robert de Niro", subtitle: "Where is the Julia's office? ASAP", date: "10 Jun", unreadCount: 0, isOnline: false),
            ChatViewModel(image: UIImage(named: "punisher"), title: "Frank", subtitle: "One batch, two batch, penny and dime", date: "03 Sep", unreadCount: 3, isOnline: true)
        ],
        "My mentors": [
            ChatViewModel(image: UIImage(named: "obama"), title: "Barack Obama", subtitle: "The cynics maybe the loudest voices", date: "08 Oct", unreadCount: 2, isOnline: true),
            ChatViewModel(image: UIImage(named: "malcolm"), title: "Malcolm X", subtitle: "Hey man, be peaceful, be courteous, obey the law, respect everyone", date: "07 Oct", unreadCount: 0, isOnline: false),
            ChatViewModel(image: UIImage(named: "feynman"), title: "Mr. Feynman", subtitle: "Surely you are joking", date: "18 Aug", unreadCount: 5, isOnline: false),
            ChatViewModel(image: UIImage(named: "einstein"), title: "Einstein", subtitle: "Everything is relative boy", date: "21 Apr", unreadCount: 0, isOnline: true),
            ChatViewModel(image: UIImage(named: "mandela"), title: "Madiba", subtitle: "Say hi to Trevor Noah", date: "05 Jun", unreadCount: 3, isOnline: true),
            ChatViewModel(image: UIImage(named: "turing"), title: "Alan Turing", subtitle: "Did you try SwiftUI?", date: "03 Jul", unreadCount: 0, isOnline: true),
            ChatViewModel(image: UIImage(named: "tesla"), title: "Tesla", subtitle: "Man!! They named a car after me", date: "03 Sep", unreadCount: 3, isOnline: true),
            ChatViewModel(image: UIImage(named: "hawking"), title: "Hawking", subtitle: "Let me tell you about the universe", date: "10 Jun", unreadCount: 0, isOnline: false)
        ],
        "Work": [
            ChatViewModel(image: UIImage(named: "bob"), title: "Uncle Bob", subtitle: "Functions should do one thing", date: "08 Oct", unreadCount: 0, isOnline: false),
            ChatViewModel(image: UIImage(named: "fowler"), title: "Mr. Fowler", subtitle: "Any fool can write code that a computer can understand", date: "07 Oct", unreadCount: 0, isOnline: false),
            ChatViewModel(image: UIImage(named: "dean"), title: "Jeff Senior", subtitle: "I mapped and reduced it", date: "18 Aug", unreadCount: 3, isOnline: true),
            ChatViewModel(image: UIImage(named: "linux"), title: "Linux guy", subtitle: "Nvidia, f you!", date: "21 Apr", unreadCount: 0, isOnline: false),
            ChatViewModel(image: UIImage(named: "dhh"), title: "DHH", subtitle: "Can you help me inverting a binary tree?", date: "05 Jun", unreadCount: 4, isOnline: true),
            ChatViewModel(image: UIImage(named: "dan"), title: "Dan", subtitle: "Suspense's release is tomorrow", date: "03 Jul", unreadCount: 0, isOnline: false),
            ChatViewModel(image: UIImage(named: "sundell"), title: "John", subtitle: "As readable as possible", date: "03 Sep", unreadCount: 5, isOnline: true),
            ChatViewModel(image: UIImage(named: "lattner"), title: "Chris Lattner", subtitle: "It will compile faster, I promise", date: "10 Jun", unreadCount: 0, isOnline: false)
        ]
    ]
}
