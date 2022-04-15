//
//  ProfileViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit
import SnapKit

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

        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(captionLabel)

        captionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(19)
            $0.leading.trailing.equalToSuperview().inset(25)
        }

        view.addSubview(logoutButton)

        logoutButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(136)
            $0.centerX.equalToSuperview()
        }
    }

    // MARK: - Navigation

    @objc private func showMessages() {
        let controller = MessagesViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
