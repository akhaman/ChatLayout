//
//  ProfileViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = "Alex Tsimikas"
        view.backgroundColor = .adaptedFor(light: .primaryWhite, dark: .primaryBlack)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Messages",
            style: .plain,
            target: self,
            action: #selector(messagesButtonTapped)
        )
        view.addSubview(logoutButton)
//        logoutButton.constraint {
//            $0.cen
//        }

    }

    @objc private func messagesButtonTapped() {
    }
}
