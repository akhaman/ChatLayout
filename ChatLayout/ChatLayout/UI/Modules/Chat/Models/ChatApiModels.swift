//
//  ChatMessage.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 11.10.2021.
//

import Foundation

struct ReceivedMessage: Dated {
    let messageId: String
    let date: Date
    let messageText: String
    let authorId: String
}

extension ReceivedMessage {

    static func new(messageText: String, authorId: String, date: Date = .now) -> ReceivedMessage {
        ReceivedMessage(
            messageId: .uuid,
            date: date,
            messageText: messageText,
            authorId: authorId
        )
    }
}

extension ReceivedMessage {

    static func mockChatHistory(currentUserId: String, anotherUserId: String) -> [ReceivedMessage] {
        let history = [
            new(
                messageText: "Alex, let’s meet this weekend. I’ll check with Dave too 😎!",
                authorId: anotherUserId,
                date: .from(year: 2021, month: 9, day: 14, hour: 8, minute: 27, second: 5)
            ),
            new(
                messageText: "Sure. Let’s aim for saturday",
                authorId: currentUserId,
                date: .from(year: 2021, month: 9, day: 14, hour: 8, minute: 56, second: 0)
            ),
            new(
                messageText: "I’m visiting mom this sunday 👻",
                authorId: currentUserId,
                date: .from(year: 2021, month: 9, day: 14, hour: 8, minute: 56, second: 22)
            ),
            new(
                messageText: "Alrighty! Will give you a call shortly 🤗",
                authorId: anotherUserId,
                date: .from(year: 2021, month: 9, day: 14, hour: 9, minute: 1, second: 2)
            ),
            new(
                messageText: "❤️",
                authorId: currentUserId,
                date: .from(year: 2021, month: 9, day: 14, hour: 9, minute: 4, second: 49)
            ),
            new(
                messageText: "Hey you! Are you there?",
                authorId: anotherUserId,
                date: .today(hour: 11, minute: 53, second: 2)
            ),
            new(
                messageText: "👋 Hi Jess! What’s up?",
                authorId: currentUserId,
                date: .today(hour: 12, minute: 14, second: 4)
            ),
            new(
                messageText: """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                """,
                authorId: currentUserId,
                date: .today(hour: 12, minute: 14, second: 30)
            ),
            new(
                messageText: """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
                Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                """,
                authorId: anotherUserId,
                date: .today(hour: 12, minute: 14, second: 56)
            ),
            new(
                messageText: """
                Some text
                """,
                authorId: anotherUserId,
                date: .today(hour: 12, minute: 14, second: 58)
            )
        ]
        
        return history
    }
}

private extension Date {

    static func from(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second

        return Calendar.current.date(from: components)!
    }

    static func today(hour: Int, minute: Int, second: Int) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        components.hour = hour
        components.minute = minute
        components.second = second

        return Calendar.current.date(from: components)!
    }
}
