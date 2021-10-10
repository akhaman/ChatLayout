//
//  ChatModels.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 09.10.2021.
//

import UIKit

// MARK: - ChatSectionModel

struct ChatSectionModel {
    let sectionId: String
    let dateText: String
    let messages: [ChatMessageModel]
}

extension ChatSectionModel: Hashable {

    static func == (lhs: ChatSectionModel, rhs: ChatSectionModel) -> Bool {
        lhs.sectionId == rhs.sectionId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(sectionId)
    }
}

// MARK: - ChatMessageModel

struct ChatMessageModel {
    let messageId: String
    let messageText: String
    let timeText: String?
    let style: Style

    enum Style {
        case incoming(author: Author)
        case outgoing
    }

    struct Author {
        let image: UIImage
    }
}

extension ChatMessageModel {

    var isIncoming: Bool {
        switch style {
        case .incoming:
            return true
        case .outgoing:
            return false
        }
    }

    var avatarImage: UIImage? {
        switch style {
        case .incoming(let author):
            return author.image
        case .outgoing:
            return nil
        }
    }
}

extension ChatMessageModel: Hashable {

    static func == (lhs: ChatMessageModel, rhs: ChatMessageModel) -> Bool {
        lhs.messageId == rhs.messageId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
}
