//
//  ChatViewController.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 07.10.2021.
//

import UIKit

class ChatViewController: UIViewController {

    private let chatPreview: ChatPreview
    private lazy var chatView = ChatView()

    // MARK: - Init

    init(chatPreview: ChatPreview) {
        self.chatPreview = chatPreview
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
        chatView.update(withSections: mockData())
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
        title = chatPreview.firstName
        navigationItem.largeTitleDisplayMode = .never
        
    }
}

// MARK: - Keyboard Hanlding

extension ChatViewController {

    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardFrameChange(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func handleKeyboardFrameChange(notification: Notification)  {

    }
}

// MARK: - Data

extension ChatViewController {
    private func mockData() -> [ChatSectionModel] {
        (0...10).map { sectionIndex in
            ChatSectionModel(
                sectionId: .uuid,
                dateText: "Date \(sectionIndex)",
                messages: (0...5).map {
                    ChatMessageModel(
                        messageId: .uuid,
                        messageText: "Some text for \($0)",
                        timeText: "Some time",
                        style: .incoming(author: .init(image: .jessica))
                    )
                }
            )
        }
    }
}
