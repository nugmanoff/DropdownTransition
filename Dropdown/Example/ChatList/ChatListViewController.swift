//
//  ViewController.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 9/29/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

// @TODO static let transitioningDelegate
// @TODO handle largetitle, searchbar?

import UIKit

final class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    lazy var navigationTitleButton = NavigationTitleButtonWithArrow()
    
    private let chats: [ChatViewModel] = [
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
        .init(image: UIImage(named: "therock"), title: "The Rock", subtitle: "Hey, am I going to be the star in the next Jumanji movie?", date: "08 Oct", unreadCount: 3, isOnline: true),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitleButton.addTarget(self, action: #selector(navigationTitleButtonDidPress), for: .touchUpInside)
        navigationItem.titleView = navigationTitleButton
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        setupNavigationBar()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.configure(with: chats[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentChatFolderListViewController()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    @objc private func navigationTitleButtonDidPress() {
        UIView.animate(withDuration: 0.2) {
            self.navigationTitleButton.toggleArrow()
        }
        presentChatFolderListViewController()
    }
    
    private func presentChatFolderListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatFolderListViewController = storyboard.instantiateViewController(identifier: "ChatFolderListViewController") as! ChatFolderListViewController
        chatFolderListViewController.onDidDismiss = {
            UIView.animate(withDuration: 0.2) {
                self.navigationTitleButton.toggleArrow()
            }
        }
        chatFolderListViewController.transitioningDelegate = dropdownTransitioningDelegate
        chatFolderListViewController.modalPresentationStyle = .custom
        navigationController?.present(chatFolderListViewController, animated: true, completion: nil)
    }
}

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
    
    private var arrowDirection: ArrowDirection = .down
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        semanticContentAttribute = .forceRightToLeft
        setTitleColor(.black, for: .normal)
        setTitle("Personal Chats", for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        let image = UIImage(systemName: "chevron.down")?.withConfiguration(UIImage.SymbolConfiguration(weight: .semibold)).withTintColor(UIColor(hexString: "#3769F0"))
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
