//
//  ChatFolderListViewController.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 10/1/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import DropdownTransition
import UIKit

final class ChatFolderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DropdownPresentable {
    @IBOutlet private weak var tableView: IntrinsicTableView!
    private var currentChatFolderName = String()

    var dismissAfterRelease: Bool { false }
    var onDidDismiss: ((String) -> Void)?

    private let folders: [ChatFolderViewModel] = ChatFolderViewModel.default

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: "ChatFolderCell", bundle: nil), forCellReuseIdentifier: "ChatFolderCell")
        tableView.tableFooterView = UIView()
        currentChatFolderName = folders.first!.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatFolderCell", for: indexPath) as! ChatFolderCell
        cell.configure(with: folders[indexPath.row])
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor(hexString: "#3769F0").withAlphaComponent(0.2)
        cell.selectedBackgroundView = backgroundColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentChatFolderName = folders[indexPath.row].name
        dismiss(animated: true, completion: nil)
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
        onDidDismiss?(currentChatFolderName)
    }
}
