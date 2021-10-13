//
//  ChatModels.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 09.10.2021.
//

import UIKit

// MARK: - ChatMessagesGroup

struct ChatMessagesGroup {
    let sectionId: ChatSectionIdentifier
    let messageItems: [ChatMessageItem]
}

// MARK: - ChatSectionIdentifier

struct ChatSectionIdentifier: Hashable {
    let sectionId: String
    let dateText: String
}

// MARK: - ChatMessageItem

struct ChatMessageItem: Hashable {
    let messageId: String
    let messageText: String
    let timeText: String?
    let authorImage: UIImage?
    let style: Style
    
    enum Style {
        case incoming
        case outgoing
    }
}

extension ChatMessageItem {

    var isIncoming: Bool {
        switch style {
        case .incoming:
            return true
        case .outgoing:
            return false
        }
    }
}
