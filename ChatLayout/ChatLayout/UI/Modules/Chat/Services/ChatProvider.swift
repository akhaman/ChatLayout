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
    func observeMessages(_ callback: @escaping (_ messages: [ChatMessagesGroup]) -> Void)
}

class ChatProvider: ChatProviderProtocol {

    private let messageMapper: ChatMessageMapperProtocol

    // MARK: - Callbacks

    private var onMessagesReceived: ((_ messages: [ChatMessagesGroup]) -> Void)?

    func observeMessages(_ callback: @escaping ([ChatMessagesGroup]) -> Void) {
        onMessagesReceived = callback
    }

    // MARK: - State

    private var chatHistory: [ReceivedMessage] = []

    // MARK: - Init

    init(messageMapper: ChatMessageMapperProtocol) {
        self.messageMapper = messageMapper
    }

    // MARK: - Actions

    func loadChatHistory() {
    }

    func send(messageText: String) {
        let message = ReceivedMessage(messageId: .uuid, date: .now, messageText: messageText, authorId: "")
        chatHistory.append(message)
        let messageModels = messageMapper.map(chatMessages: chatHistory)
        onMessagesReceived?(messageModels)
    }
}
