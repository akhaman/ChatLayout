//
//  ProfileViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    private enum Constants {
        static let title = "Alex Tsimikas"
        static let logoutButtonTitle = "Logout"
        static let captionText = "Brooklyn, NY"
        static let messagesButtonItemTitle = "Messages"
    }

    // MARK: - Subviews

    private lazy var logoutButton: UIButton = RoundedButton(title: Constants.logoutButtonTitle, image: .arrowLeft)

    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 14, forTextStyle: .caption2)
        label.textColor = .adaptedFor(light: .darkGray, dark: .lighterGray)
        label.text = Constants.captionText
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Helpers

    private func setupView() {
        title = Constants.title
        view.backgroundColor = .adaptedFor(light: .primaryWhite, dark: .primaryBlack)
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title:  Constants.messagesButtonItemTitle,
            style: .plain,
            target: self,
            action: #selector(showMessages)
        )

        setupCaptionLabel()
        setupLogoutButton()
    }

    private func setupCaptionLabel() {
        view.addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19),
            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            captionLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -25)
        ])
    }

    private func setupLogoutButton() {
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 136),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    // MARK: - Navigation

    @objc private func showMessages() {
        let controller = MessagesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
