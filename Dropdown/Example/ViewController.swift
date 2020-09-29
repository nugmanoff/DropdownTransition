//
//  ViewController.swift
//  Dropdown
//
//  Created by Aidar Nugmanoff on 9/29/20.
//  Copyright © 2020 Aidar Nugmanoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func present() {
        let vc = AnotherViewController()
        vc.transitioningDelegate = dropdownTransitioningDelegate
        vc.modalPresentationStyle = .custom
        navigationController?.present(vc, animated: true, completion: nil)
    }
}



class AnotherViewController: UIViewController, DropdownPresentable {
    var dismissTranslationThreshold: CGFloat = 150
    var stretchableBackgroundColor: UIColor = .red
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        updatePreferredContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updatePreferredContentSize()
    }
    
    private func updatePreferredContentSize() {
        view.updateConstraintsIfNeeded()
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
    }
}
