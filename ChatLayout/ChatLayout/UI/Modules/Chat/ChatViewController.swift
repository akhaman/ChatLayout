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

    // MARK: - Helpers

    private func setupView() {
        title = chatPreview.firstName
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension ChatViewController {
    private func mockData() -> [ChatSectionModel] {
        (0...10).map { sectionIndex in
            ChatSectionModel(
                sectionId: .uuid,
                dateText: "Date \(sectionIndex)",
                messages: (0...5).map {
                    ChatMessageModel(
                        messageId: .uuid,
                        messageText: "Some text for examdfjlksdafj;lkasdjfkl;asdfj;lksdajfl;ksdjfl;sdjf;lksdfj;klsdjf;lksdjfklds;fj;kdlsfj;ldskjf;lsdjfldsjfdsjfl;dsjf;sdjf;sdljf;lasdjf;lsdjf;lsdjf;lsdkjf;lasjf;lasdjf;lasdj;lple \($0)",
                        timeText: nil,
                        style: .outgoing
                    )
                }
            )
        }
    }
}
