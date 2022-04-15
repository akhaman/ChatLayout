//
//  ChatViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 07.10.2021.
//

import UIKit

class ChatViewController: UIViewController {
    private lazy var chatView = ChatView()

    // MARK: Properties

    private let chatProvider: ChatProviderProtocol

    // MARK: Init

    init(chatName: String, chatProvider: ChatProviderProtocol) {
        self.chatProvider = chatProvider
        super.init(nibName: nil, bundle: nil)
        title = chatName
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.chatProvider.loadChatHistory()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatView.addKeyboardObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        chatView.removeKeyboardObservers()
    }

    // MARK: Helpers

    private func setupView() {
        navigationItem.largeTitleDisplayMode = .never

        chatView.observeSendButtonTap { [weak self] messageText in
            self?.chatProvider.send(messageText: messageText)
        }

        chatProvider.observeChatHistoryLoading { [weak self] groups in
            self?.chatView.reload(groups: groups)
            self?.chatView.scrollToLastMessage(animated: false)
        }

        chatProvider.observeMessagesReceiving { [weak self] groups in
            self?.chatView.reload(groups: groups)
            self?.chatView.scrollToLastMessage(animated: true)
        }
    }
}
