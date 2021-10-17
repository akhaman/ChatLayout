//
//  ChatMessageMapper.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 11.10.2021.
//

import Foundation

protocol ChatMessageMapperProtocol {
    func map(chatMessages: [ReceivedMessage], currentUserId: String) -> [ChatMessagesGroup]
}

class ChatMessageMapper: ChatMessageMapperProtocol {

    func map(chatMessages: [ReceivedMessage], currentUserId: String) -> [ChatMessagesGroup] {
        chatMessages.groupedBy(dateComponents: .year, .month, .day)
            .sorted { $0.key < $1.key }
            .map { date, messages in
                ChatMessagesGroup(
                    sectionId: ChatSectionIdentifier(sectionId: .uuid, dateText: formattedDate(from: date)),
                    messageItems: messageItems(from: messages, currentUserId: currentUserId)
                )
            }
    }

    // MARK: - Helpers

    private func messageItems(from messages: [ReceivedMessage], currentUserId: String) -> [ChatMessageItem] {
        messages.segmented.map { previous, current, next in
            let isLastInGroup = isLastInGroup(current: current, next: next)

            return ChatMessageItem(
                messageId: current.messageId,
                messageText: current.messageText,
                timeText: isLastInGroup ? formatTime(from: current.date) : nil,
                authorImage: isLastInGroup ? current.authorImage : nil,
                style: current.authorId == currentUserId ? .outgoing : .incoming
            )
        }
    }

    private func isLastInGroup(current: ReceivedMessage, next: ReceivedMessage?) -> Bool {
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
