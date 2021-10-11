//
//  ChatModels.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 09.10.2021.
//

import UIKit

// MARK: - ChatSectionViewModel

struct ChatSectionViewModel {
    let sectionId: String
    let dateText: String
    let messages: [ChatMessageViewModel]
}

extension ChatSectionViewModel: Hashable {

    static func == (lhs: ChatSectionViewModel, rhs: ChatSectionViewModel) -> Bool {
        lhs.sectionId == rhs.sectionId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(sectionId)
    }
}

extension ChatSectionViewModel {
}

// MARK: - ChatMessageViewModel

struct ChatMessageViewModel {
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

extension ChatMessageViewModel {

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

extension ChatMessageViewModel: Hashable {

    static func == (lhs: ChatMessageViewModel, rhs: ChatMessageViewModel) -> Bool {
        lhs.messageId == rhs.messageId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
}
