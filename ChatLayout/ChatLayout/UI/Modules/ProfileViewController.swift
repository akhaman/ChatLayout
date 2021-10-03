//
//  ProfileViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "Alex Tsimikas"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Messages",
            style: .plain,
            target: self,
            action: #selector(messagesButtonTapped)
        )
    }

    @objc private func messagesButtonTapped() {
    }
}
