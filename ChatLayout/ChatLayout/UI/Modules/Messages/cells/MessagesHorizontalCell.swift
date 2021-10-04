//
//  MessagesHorizontalCell.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 04.10.2021.
//

import UIKit

class MessagesHorizontalCell: UICollectionViewCell {

    // MARK: - UI

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lighterGray
        view.layer.cornerRadius = 40 / 2
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 14, forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .adaptedFor(light: .darkGray, dark: .socialWhite)
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 14, forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .adaptedFor(light: .lighterGray, dark: .socialWhite)
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 12, forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .adaptedFor(light: .pureBlack, dark: .lighterGray)
        return label
    }()

    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = isHighlighted ? .opaqueSeparator : .clear
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupNameLabel()
        setupMessageLabel()
        setupDateLabel()
        addSeparators()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
        ])
    }

    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
        ])
    }

    private func setupMessageLabel() {
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 43)
        ])
    }

    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }

    // MARK: - Updating

    @discardableResult
    func updated(with chat: Chat) -> Self {
        imageView.image = chat.image
        nameLabel.text = chat.name
        messageLabel.text = chat.message
        dateLabel.text = chat.date
        return self
    }
}

extension MessagesHorizontalCell {
    private func addSeparators() {
        let top = UIView()
        top.backgroundColor = .separator
        top.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(top)
        NSLayoutConstraint.activate([
            top.topAnchor.constraint(equalTo: contentView.topAnchor),
            top.heightAnchor.constraint(equalToConstant: 0.5),
            top.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            top.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

typealias Chat = MessagesView.Chat
