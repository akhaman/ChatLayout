//
//  ProfileViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var logoutButton: UIButton = RoundedButton(title: "Logout", image: .arrowLeft)

    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 14, forTextStyle: .caption2)
        label.textColor = .adaptedFor(light: .darkGray, dark: .lighterGray)
        label.text = "Brooklyn, NY"
        return label
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

        view.addSubview(captionLabel)
        captionLabel.layout {
            $0.left(equalTo: .left, of: view, with: 25)
            $0.top(equalTo: .top, of: view, with: 19)
        }

        view.addSubview(logoutButton)
        logoutButton.layout {
            $0.centerXEqualToSuperview()
            $0.top(equalTo: .top, of: view, with: 136)
        }
    }

    @objc private func messagesButtonTapped() {
    }
}
