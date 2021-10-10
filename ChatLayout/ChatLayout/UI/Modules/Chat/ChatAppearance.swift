//
//  ChatAppearance.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 10.10.2021.
//

import UIKit

enum ChatAppearance {

    static let backgroundColor = UIColor.adaptedFor(light: .primaryWhite, dark: .primaryBlack)
    static let sectionInsets = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
    static let minimumLineSpacing: CGFloat = 4

    enum TextMessage {
        static let maxBubbleWidth = UIScreen.main.bounds.width * 0.7
        static let outgoingBubbleRightInset: CGFloat = 26
        static let incomingBubleLeftInset: CGFloat = 47
        static let outgoingBubbleColor = UIColor.socialBlue
        static let incomingBubbleColor = UIColor.adaptedFor(light: .messageLighterGray, dark: .darkGray)

        static let messageFont = UIFont.font(ofSize: 14, forTextStyle: .body)
        static let outgoingMessageColor = UIColor.primaryWhite
        static let incomingMessageColor = UIColor.adaptedFor(light: .primaryBlack, dark: .primaryWhite)
        static let messageTextInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
        static let messageParagraphStyle: NSParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.alignment = .left
            style.lineBreakMode = .byWordWrapping
            style.lineSpacing = 3
            return style
        }()

        static let timeFont = UIFont.font(ofSize: 12, forTextStyle: .caption2)
        static let outgoingTimeColor = UIColor.lighterGray
        static let incomingTimeColor = UIColor.adaptedFor(light: .primaryBlack, dark: .lighterGray)
        static let timeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 20, right: 0)
    }
}
