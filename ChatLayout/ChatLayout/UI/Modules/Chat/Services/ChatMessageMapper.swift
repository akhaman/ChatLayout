//
//  ChatMessageMapper.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 11.10.2021.
//

import Foundation

protocol ChatMessageMapperProtocol {
    func map(chatMessages: [ReceivedMessage]) -> [ChatMessagesGroup]
}

class ChatMessageMapper: ChatMessageMapperProtocol {

    private let currentUserId: String

    init(currentUserId: String) {
        self.currentUserId = currentUserId
    }

    func map(chatMessages: [ReceivedMessage]) -> [ChatMessagesGroup] {
        chatMessages.groupedBy(dateComponents: .year, .month, .day)
            .sorted { $0.key > $1.key }
            .map { date, messages in
                ChatMessagesGroup(
                    sectionId: ChatSectionIdentifier(sectionId: .uuid, dateText: formattedDate(from: date)),
                    messageItems: messageItems(from: messages)
                )
            }
    }

    // MARK: - Helpers

    private func messageItems(from messages: [ReceivedMessage]) -> [ChatMessageItem] {
        messages.segmented.map { previous, current, next in
            ChatMessageItem(
                messageId: current.messageId,
                messageText: current.messageText,
                timeText: isLastInBlock(current: current, next: next) ? formatTime(from: current.date) : nil,
                authorImage: isLastInBlock(current: current, next: next) ? .jessica : nil,
                style: current.authorId == currentUserId ? .outgoing : .incoming
            )
        }
    }

    private func isLastInBlock(current: ReceivedMessage, next: ReceivedMessage?) -> Bool {
        guard let next = next else { return true }

        if  current.authorId == next.authorId {
            return !current.date.equals(with: next.date, by: .hour, .minute)
        } else {
            return true
        }
    }

    private func formattedDate(from date: Date) -> String {
        date.isToday ? "TODAY" : Self.dateFormatter.string(from: date)
    }

    private func formatTime(from date: Date) -> String {
        Self.timeFormatter.string(from: date)
    }
}

// MARK: - Formatters

extension ChatMessageMapper {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        formatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return formatter
    }()
}
