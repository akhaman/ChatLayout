//
//  ChatProvider.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 11.10.2021.
//

import Foundation

struct ChatState {
    var messages: [ChatMessage]
}

protocol ChatProvider: AnyObject {
    var onStateDidChange: ((_ state: ChatState) -> Void)? { get set }
    func loadChatHistory()
    func send(message: ChatMessage)
}

class ChatProviderImpl: ChatProvider {

    // MARK: - StateObserving

    var onStateDidChange: ((_ state: ChatState) -> Void)?

    // MARK: - State

    private var chatState: ChatState

    // MARK: - Init

    init() {
        chatState = ChatState(messages: [])
    }

    // MARK: - Actions

    func loadChatHistory() {

    }

    func send(message: ChatMessage) {
        chatState.messages.append(message)
        onStateDidChange?(chatState)
    }
}
