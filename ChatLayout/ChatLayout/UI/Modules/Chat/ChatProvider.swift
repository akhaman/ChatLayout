//
//  ChatProvider.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 11.10.2021.
//

import Foundation

protocol ChatProviderProtocol: AnyObject {
    func loadChatHistory()
    func send(messageText: String)

    func observeMessages(_ callback: @escaping (_ messages: [ChatSectionViewModel]) -> Void)
}

class ChatProvider: ChatProviderProtocol {

    private let messageMapper: ChatMessageMapperProtocol

    // MARK: - Callbacks

    private var onMessagesReceived: ((_ messages: [ChatSectionViewModel]) -> Void)?

    func observeMessages(_ callback: @escaping ([ChatSectionViewModel]) -> Void) {
        onMessagesReceived = callback
    }

    // MARK: - State

    private var chatHistory: [ChatMessage] = []

    // MARK: - Init

    init(messageMapper: ChatMessageMapperProtocol = ChatMessageMapper()) {
        self.messageMapper = messageMapper
    }

    // MARK: - Actions

    func loadChatHistory() {

    }

    func send(messageText: String) {
        let message = ChatMessage(messageId: .uuid, date: .now, messageText: messageText, sender: .currentUser)
        chatHistory.append(message)
        let sections = messageMapper.map(chatMessages: chatHistory)
        onMessagesReceived?(sections)
    }
}
