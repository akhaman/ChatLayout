//
//  MessagesViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 03.10.2021.
//

import UIKit

class MessagesViewController: UIViewController {

    private enum Constants {
        static let title = "MESSAGES"
        static let searchPlaceholder = "Who do you want to chat with?"
    }

    private lazy var messagesView = MessagesView()

    // MARK: - Life Cycle

    override func loadView() {
        view = messagesView
        messagesView.onSelectChat = { [weak self] in self?.didSelect(chat: $0) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mockData()
    }

    // MARK: - Helpers

    private func setupView() {
        title = Constants.title
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .adaptedFor(light: .primaryWhite, dark: .primaryBlack)
        setupSearchBar()
    }

    private func setupSearchBar() {
        let searchController = UISearchController()
        let textField = searchController.searchBar.searchTextField
        textField.attributedPlaceholder = NSAttributedString(
            string: Constants.searchPlaceholder,
            attributes: [
                .foregroundColor: UIColor.adaptedFor(light: .lighterGray, dark: .socialWhite),
                .font: UIFont.font(ofSize: 17, forTextStyle: .body)
            ]
        )
        navigationItem.searchController = searchController
    }

    // MARK: - Actions

    private func didSelect(chat: ChatPreview) {
    }
}

extension MessagesViewController {
    private func mockData() {
        let pinned = (0...20).map {
            ChatPreview(id: "\($0)", firstName: "FirstName \($0)", lastName: "LastName", image: .backIcon, message: "Some message \($0)", date: "19/02/30")
        }

        let listed = (21...40).map {
            ChatPreview(id: "\($0)", firstName: "FirstName \($0)", lastName: "LastName", image: .backIcon, message: "Some message \($0)", date: "19/02/30")
        }

        messagesView.update(pinnedChats: pinned, listedChats: listed)
    }
}
