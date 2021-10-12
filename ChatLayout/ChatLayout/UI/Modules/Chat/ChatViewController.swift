//
//  ChatViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 07.10.2021.
//

import UIKit

class ChatViewController: UIViewController {

    private lazy var chatView = ChatView()

    // MARK: - Properties

    private let chatName: String
    private let chatProvider: ChatProviderProtocol

    // MARK: - Init

    init(chatName: String, chatProvider: ChatProviderProtocol) {
        self.chatName = chatName
        self.chatProvider = chatProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        chatProvider.loadChatHistory()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }

    // MARK: - Helpers

    private func setupView() {
        title = chatName
        navigationItem.largeTitleDisplayMode = .never

        chatView.onSendMessageButtonDidTap = { [unowned self] messageText in
            chatProvider.send(messageText: messageText)
        }

        chatProvider.observeMessages { [weak self] sections in
            self?.chatView.reload(withSections: sections)
            self?.chatView.scrollToLastMessage()
        }
    }
}

// MARK: - Keyboard Handling

extension ChatViewController {

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardFrameChange(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func handleKeyboardFrameChange(notification: Notification)  {
    }
}
