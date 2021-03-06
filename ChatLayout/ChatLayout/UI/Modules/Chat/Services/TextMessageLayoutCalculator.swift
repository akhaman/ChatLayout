//
//  ChatLayoutCalculator.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 10.10.2021.
//

import UIKit

class TextMessageLayoutCalculator {
    static func calculate(forMessage model: ChatMessageItem) -> Result {
        let attributedMessage = makeAttributedMessage(from: model.messageText, isIncoming: model.isIncoming)
        let messageFrame = frame(forMessageLabelWith: attributedMessage)
        let bubbleFrame = frame(forBubbleWithMessageFrame: messageFrame, isIncoming: model.isIncoming)
        let attributedTime = model.timeText.map { makeAttributedTime(from: $0, isIncoming: model.isIncoming) }
        let timeFrame = attributedTime.map { frame(forTimeLabelWith: $0, bubbleFrame: bubbleFrame, isIncoming: model.isIncoming) }
        let avatarFrame = avatarFrame(forCellStyle: model.style)

        return Result(
            bubbleFrame: bubbleFrame,
            messageFrame: messageFrame,
            attributedMessage: attributedMessage,
            timeFrame: timeFrame ?? .zero,
            attributedTime: attributedTime,
            avatarFrame: avatarFrame
        )
    }

    static func size(forCellWithMessage message: ChatMessageItem) -> CGSize {
        let result = calculate(forMessage: message)
        let bottomOffset = result.attributedTime == nil ? .zero : ChatAppearance.TextMessage.timeInsets.bottom
        let cellHeight = result.bubbleFrame.height + result.timeFrame.height + bottomOffset
        let cellSize = CGSize(width: screenWidth, height: cellHeight)

        return cellSize
    }

    // MARK: - Helpers

    private static var messageHorizontalInsets: CGFloat {
        let insets = ChatAppearance.TextMessage.messageTextInsets
        return insets.left + insets.right
    }

    private static var messageVerticalInsets: CGFloat {
        let insets = ChatAppearance.TextMessage.messageTextInsets
        return insets.top + insets.bottom
    }

    private static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    private static func makeAttributedMessage(from string: String, isIncoming: Bool) -> NSAttributedString {
        NSAttributedString(string: string, attributes: [
            .font: ChatAppearance.TextMessage.messageFont,
            .paragraphStyle: ChatAppearance.TextMessage.messageParagraphStyle,
            .foregroundColor: isIncoming
                ? ChatAppearance.TextMessage.incomingMessageColor
                : ChatAppearance.TextMessage.outgoingMessageColor
        ])
    }

    private static func makeAttributedTime(from string: String, isIncoming: Bool) -> NSAttributedString {
        NSAttributedString(string: string, attributes: [
            .font: ChatAppearance.TextMessage.timeFont,
            .foregroundColor: isIncoming
                ? ChatAppearance.TextMessage.incomingTimeColor
                : ChatAppearance.TextMessage.outgoingTimeColor
        ])
    }

    private static func frame(forBubbleWithMessageFrame messageFrame: CGRect, isIncoming: Bool) -> CGRect {
        let bubbleSize = CGSize(
            width: max(messageFrame.width + messageHorizontalInsets, ChatAppearance.TextMessage.minBubbleWidth),
            height: messageFrame.height + messageVerticalInsets
        )

        let xOrigin = isIncoming
            ? ChatAppearance.TextMessage.incomingBubbleLeftInset
            : screenWidth - bubbleSize.width - ChatAppearance.TextMessage.outgoingBubbleRightInset

        let frame = CGRect(origin: CGPoint(x: xOrigin, y: .zero), size: bubbleSize)

        return frame
    }

    private static func avatarFrame(forCellStyle style: ChatMessageItem.Style) -> CGRect {
        switch style {
        case .outgoing:
            return .zero
        case .incoming:
            return CGRect(
                origin: CGPoint(x: ChatAppearance.TextMessage.avatarLeftInset, y: .zero),
                size: ChatAppearance.TextMessage.avatarSize
            )
        }
    }

    private static func frame(forMessageLabelWith attributedString: NSAttributedString) -> CGRect {
        let maxBubbleSize = CGSize(width: ChatAppearance.TextMessage.maxBubbleWidth, height: .greatestFiniteMagnitude)

        let maxMessageSize = CGSize(
            width: maxBubbleSize.width - messageHorizontalInsets,
            height: maxBubbleSize.height - messageVerticalInsets
        )

        var textFrame = attributedString.boundingRect(
            with: maxMessageSize,
            options: .usesFontLeading.union(.usesLineFragmentOrigin),
            context: nil
        )

        textFrame.origin.x += ChatAppearance.TextMessage.messageTextInsets.left
        textFrame.origin.y += ChatAppearance.TextMessage.messageTextInsets.top

        return textFrame
    }

    private static func frame(forTimeLabelWith attributedString: NSAttributedString, bubbleFrame: CGRect, isIncoming: Bool) -> CGRect {
        var textFrame = attributedString.boundingRect(
            with: CGSize(width: ChatAppearance.TextMessage.maxBubbleWidth, height: .greatestFiniteMagnitude),
            options: .usesFontLeading.union(.usesLineFragmentOrigin),
            context: nil
        )

        textFrame.origin.x =  isIncoming ? max(bubbleFrame.minX, bubbleFrame.maxX - textFrame.width) : bubbleFrame.maxX - textFrame.width
        textFrame.origin.y = bubbleFrame.maxY + ChatAppearance.TextMessage.timeInsets.top

        return textFrame
    }
}

// MARK: - Result Model

extension TextMessageLayoutCalculator {
    struct Result {
        let bubbleFrame: CGRect
        let messageFrame: CGRect
        let attributedMessage: NSAttributedString
        let timeFrame: CGRect
        let attributedTime: NSAttributedString?
        let avatarFrame: CGRect
    }
}
