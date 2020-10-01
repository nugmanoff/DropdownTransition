//
//  ChatFolderListViewController.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/1/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

final class ChatFolderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DropdownPresentable {
    
    @IBOutlet private weak var tableView: IntrinsicTableView!
    
    var dismissTranslationThreshold: CGFloat = 150
    var stretchableBackgroundColor: UIColor = .white
    
    var onDidDismiss: (() -> Void)?

    private let folders: [ChatFolderViewModel] = [
        .init(image: UIImage(named: "users"), imageBackgroundColor: UIColor(hexString: "#75DFF8"), name: "Personal Chats", chatCount: 7),
        .init(image: UIImage(named: "portfolio"), imageBackgroundColor: UIColor(hexString: "#EE6C3E"), name: "Bloomberg - Work", chatCount: 5),
        .init(image: UIImage(named: "star"), imageBackgroundColor: UIColor(hexString: "#6ED352"), name: "Bookmarks", chatCount: 16),
        .init(image: UIImage(named: "plus"), imageBackgroundColor: .clear, name: "Add new folder", chatCount: 0, isAnnotationHidden: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: "ChatFolderCell", bundle: nil), forCellReuseIdentifier: "ChatFolderCell")
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatFolderCell", for: indexPath) as! ChatFolderCell
        cell.configure(with: folders[indexPath.row])
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updatePreferredContentSize()
    }

    private func updatePreferredContentSize() {
        view.updateConstraintsIfNeeded()
        let viewSize = CGSize(width: UIScreen.main.bounds.width, height: .leastNonzeroMagnitude)
        preferredContentSize = view.systemLayoutSizeFitting(viewSize,
                                                            withHorizontalFittingPriority: .required,
                                                            verticalFittingPriority: .defaultLow)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        onDidDismiss?()
    }
}
    
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

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
