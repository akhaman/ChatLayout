//
//  ChatMessageMapper.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 11.10.2021.
//

import Foundation

protocol ChatMessageMapperProtocol {
    func map(chatMessages: [ChatMessage]) -> [ChatSectionViewModel]
}

class ChatMessageMapper: ChatMessageMapperProtocol {

    func map(chatMessages: [ChatMessage]) -> [ChatSectionViewModel] {
        chatMessages.groupedBy(dateComponents: .year, .month, .day)
            .sorted { $0.key > $1.key }
            .map { date, messages in
                ChatSectionViewModel(
                    sectionId: formattedDate(from: date),
                    dateText: formattedDate(from: date),
                    messages: messageViewModels(from: messages)
                )
            }
    }

    func append(chatMessage: ChatMessage, intoExistingMessages: [ChatMessage]) {
        
    }

    // MARK: - Helpers

    private func messageViewModels(from messages: [ChatMessage]) -> [ChatMessageViewModel] {
        messages.segmented.map { previous, current, next in
            let showsTime: Bool

            if let next = next {
                if current.sender != next.sender {
                    showsTime = true
                } else {
                    showsTime = !current.date.equals(with: next.date, by: .hour, .minute)
                }
            } else {
                showsTime = true
            }

            return ChatMessageViewModel(
                messageId: current.messageId,
                messageText: current.messageText,
                timeText: showsTime ? formatTime(from: current.date) : nil,
                style: style(from: current.sender)
            )
        }
    }

    private func formattedDate(from date: Date) -> String {
        date.isToday ? "TODAY" : Self.dateFormatter.string(from: date)
    }

    private func formatTime(from date: Date) -> String {
        Self.timeFormatter.string(from: date)
    }

    private func style(from sender: ChatMessage.Sender) -> ChatMessageViewModel.Style {
        switch sender {
        case .incoming:
            return .incoming(author: .init(image: .jessica))
        case .currentUser:
            return .outgoing
        }
    }
}

// MARK: - Formatters

extension ChatMessageMapper {

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
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
