//
//  MessagesViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 03.10.2021.
//

import UIKit

class MessagesViewController: UIViewController {

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
        title = "MESSAGES"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .adaptedFor(light: .primaryWhite, dark: .primaryBlack)
        setupSearchBar()
    }

    private func setupSearchBar() {
        let searchController = UISearchController()
        let textField = searchController.searchBar.searchTextField
        textField.attributedPlaceholder = NSAttributedString(
            string: "Who do you want to chat with?",
            attributes: [
                .foregroundColor: UIColor.adaptedFor(light: .lighterGray, dark: .socialWhite),
                .font: UIFont.font(ofSize: 17, forTextStyle: .body)
            ]
        )
        navigationItem.searchController = searchController
    }

    private func didSelect(chat: MessagesView.Chat) {
    }
}

extension MessagesViewController {
    private func mockData() {
        let chats = (0...20).map {
            MessagesView.Chat(id: "\($0)", name: "Some Name \($0)", image: .backIcon, message: "Some message \($0)", date: "19/02/30")
        }
        messagesView.update(pinnedChats: [], listedChats: chats)
    }
}
