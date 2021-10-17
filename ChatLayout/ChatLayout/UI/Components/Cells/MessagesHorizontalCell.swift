//
//  MessagesHorizontalCell.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 04.10.2021.
//

import UIKit

class MessagesHorizontalCell: UICollectionViewCell {

    // MARK: - Subviews

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lighterGray
        view.layer.masksToBounds = true
        view.contentMode = .scaleToFill
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
        addSeparator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Parent Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }

    // MARK: - Setup Layout

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
            messageLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -43)
        ])
    }

    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor)
        let leading = dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 8)
        let trailing = dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)

        leading.priority = .defaultLow

        NSLayoutConstraint.activate([top, leading, trailing])
    }

    // MARK: - Updating

    @discardableResult
    func updated(withFullName fullName: String, image: UIImage, message: String, date: String) -> Self {
        imageView.image = image
        nameLabel.text = fullName
        messageLabel.text = message
        dateLabel.text = date
        return self
    }
}
