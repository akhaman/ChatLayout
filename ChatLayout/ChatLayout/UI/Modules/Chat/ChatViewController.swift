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
    }

    // MARK: - Helpers

    private func setupView() {
        title = chatPreview.firstName
        
    }
}
