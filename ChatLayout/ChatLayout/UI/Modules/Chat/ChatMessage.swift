//
//  ChatMessage.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 11.10.2021.
//

import Foundation

struct ChatMessage {
    let messageId: String
    let date: Date
    let messageText: String
    let sender: Sender

    enum Sender {
        case currentUser
        case incoming
    }
}
