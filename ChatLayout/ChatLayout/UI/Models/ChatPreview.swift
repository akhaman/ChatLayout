//
//  ChatPreview.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 06.10.2021.
//

import UIKit

struct ChatPreview: Hashable {
    let id: String
    let firstName: String
    let lastName: String
    let image: UIImage
    let message: String
    let date: String

    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

// MARK: - Mock

extension ChatPreview {
    static func mock() -> [ChatPreview] {
        [
            ChatPreview(
                id: .uuid,
                firstName: "Kim",
                lastName: "Kimova",
                image: .kim,
                message: "Hey! Kak dela?",
                date: "4h ago"
            ),
            ChatPreview(
                id: .uuid,
                firstName: "Steve",
                lastName: "Stevov",
                image: .steve,
                message: "Normalno vse?",
                date: "5h ago"
            ),
            ChatPreview(
                id: .uuid,
                firstName: "Mia",
                lastName: "Miova",
                image: .mia,
                message: "OMG! OMG! OMG!",
                date: "20/9/21"
            ),
            ChatPreview(
                id: .uuid,
                firstName: "Jessica",
                lastName: "Thompson",
                image: .jessica,
                message: "Prodam garazh!",
                date: "19/9/21"
            ),
            ChatPreview(
                id: .uuid,
                firstName: "Kim",
                lastName: "Kimova",
                image: .kim,
                message: "Hey! Kak dela?",
                date: "4h ago"
            ),
            ChatPreview(
                id: .uuid,
                firstName: "Steve",
                lastName: "Stevov",
                image: .steve,
                message: "Normalno vse?",
                date: "5h ago"
            ),
            ChatPreview(
                id: .uuid,
                firstName: "Mia",
                lastName: "Miova",
                image: .mia,
                message: "OMG! OMG! OMG!",
                date: "20/9/21"
            ),
            ChatPreview(
                id: .uuid,
                firstName: "Jessica",
                lastName: "Thompson",
                image: .jessica,
                message: "Prodam garazh!",
                date: "19/9/21"
            )
        ]
    }
}
