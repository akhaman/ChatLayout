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
