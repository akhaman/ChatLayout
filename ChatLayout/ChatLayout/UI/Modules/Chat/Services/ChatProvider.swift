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
    func observeChatHistoryLoading(_ callback: @escaping ([ChatMessagesGroup]) -> Void) 
    func observeMessagesReceiving(_ callback: @escaping (_ messages: [ChatMessagesGroup]) -> Void)
}

class ChatProvider: ChatProviderProtocol {

    private let messageMapper: ChatMessageMapperProtocol
    private let currentUserId: String
    private let anotherUserId: String

    // MARK: - Callbacks

    private var onMessagesReceived: ((_ messages: [ChatMessagesGroup]) -> Void)?
    private var onChatHistoryLoaded: ((_ messages: [ChatMessagesGroup]) -> Void)?
    // MARK: - State

    private var chatHistory: [ReceivedMessage] = []

    // MARK: - Initialization

    init(messageMapper: ChatMessageMapperProtocol, currentUserId: String, anotherUserId: String) {
        self.messageMapper = messageMapper
        self.currentUserId = currentUserId
        self.anotherUserId = anotherUserId
    }

    // MARK: - Actions

    func observeChatHistoryLoading(_ callback: @escaping ([ChatMessagesGroup]) -> Void) {
        onChatHistoryLoaded = callback
    }

    func observeMessagesReceiving(_ callback: @escaping ([ChatMessagesGroup]) -> Void) {
        onMessagesReceived = callback
    }

    func loadChatHistory() {
        chatHistory = ReceivedMessage.mockChatHistory(currentUserId: currentUserId, anotherUserId: anotherUserId)
        let mappedMessages = messageMapper.map(chatMessages: chatHistory, currentUserId: currentUserId)
        // Вот тута кидаем вызов каллбека в конец очереди тк иначе collection view не скролится к последнему сообщению.
        // Причина не совсем ясна. Возможно не успевает свой лейаут нормально посчитать.
        DispatchQueue.main.async { [weak self] in
            self?.onChatHistoryLoaded?(mappedMessages)
        }
    }

    func send(messageText: String) {
        let message = ReceivedMessage.new(messageText: messageText, authorId: currentUserId)
        chatHistory.append(message)
        let mappedMessages = messageMapper.map(chatMessages: chatHistory, currentUserId: currentUserId)
        onMessagesReceived?(mappedMessages)
    }
}
