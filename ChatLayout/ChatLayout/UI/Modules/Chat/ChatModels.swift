//
//  ChatModels.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 09.10.2021.
//

import UIKit

// MARK: - ChatSectionViewModel

struct ChatSectionViewModel: Hashable {
    let sectionId: String
    let dateText: String
    let messages: [ChatMessageViewModel]
}

// MARK: - ChatMessageViewModel

struct ChatMessageViewModel: Hashable {
    let messageId: String
    let messageText: String
    let timeText: String?
    let style: Style
}

extension ChatMessageViewModel {

    enum Style: Hashable {
        case incoming(author: Author)
        case outgoing

        static func == (lhs: ChatMessageViewModel.Style, rhs: ChatMessageViewModel.Style) -> Bool {
            switch (lhs, rhs) {
            case (.outgoing, .outgoing):
                return true
            case (.incoming(let author), .incoming(let author2)):
                return author == author2
            default:
                return false
            }
        }
    }

    struct Author: Hashable {
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
