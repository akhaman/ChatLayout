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
        messagesView.onSelectChat = { [unowned self] in didSelect(chat: $0) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        messagesView.update(pinnedChats: ChatPreview.mock(), listedChats: ChatPreview.mock())
    }

    // MARK: - Helpers

    private func setupView() {
        title = Constants.title
        navigationItem.largeTitleDisplayMode = .never
        setupSearchBar()
    }

    private func setupSearchBar() {
        let searchController = UISearchController()

        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
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
