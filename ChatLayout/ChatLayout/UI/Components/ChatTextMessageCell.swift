//
//  ChatTextMessageCell.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 09.10.2021.
//

import UIKit

class ChatTextMessageCell: UICollectionViewCell {

    // MARK: - Subviews

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = ChatAppearance.TextMessage.avatarSize.height / 2
        return imageView
    }()

    private lazy var bubbleContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .socialBlue
        return view
    }()

    private lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory  = true
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Updating

    func updated(withMessage message: ChatMessageViewModel) -> Self {
        avatarImageView.image = message.avatarImage
        let result = TextMessageLayoutCalculator.calculate(forMessage: message)
        updateLayout(withResult: result)
        updateBubble(forStyle: message.style)
        return self
    }

    // MARK: - Helpers

    private func setup() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(bubbleContentView)
        bubbleContentView.addSubview(messageTextLabel)
        contentView.addSubview(timeLabel)
    }

    private func updateLayout(withResult result: TextMessageLayoutCalculator.Result) {
        bubbleContentView.frame = result.bubbleFrame
        messageTextLabel.frame = result.messageFrame
        messageTextLabel.attributedText = result.attributedMessage
        timeLabel.frame = result.timeFrame
        timeLabel.attributedText = result.attributedTime
        avatarImageView.frame = result.avatarFrame
    }

    private func updateBubble(forStyle style: ChatMessageViewModel.Style) {
        let rectCorners: UIRectCorner
        let bubbleColor: UIColor

        switch style {
        case .outgoing:
            rectCorners = [.topLeft, .topRight, .bottomLeft]
            bubbleColor = ChatAppearance.TextMessage.outgoingBubbleColor
        case .incoming:
            rectCorners = [.topRight, .bottomLeft, .bottomRight]
            bubbleColor = ChatAppearance.TextMessage.incomingBubbleColor
        }

        bubbleContentView.backgroundColor = bubbleColor
        bubbleContentView.layer.cornerRadius = 4

        let maskPath = UIBezierPath(
            roundedRect: bubbleContentView.bounds,
            byRoundingCorners: rectCorners,
            cornerRadii: CGSize(width: 20, height: 0)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        bubbleContentView.layer.mask = maskLayer
    }
}
