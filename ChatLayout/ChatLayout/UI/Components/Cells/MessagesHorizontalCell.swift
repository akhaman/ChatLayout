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
        setupLayout()
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

    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.top)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
        }

        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.greaterThanOrEqualToSuperview().inset(43)
        }

        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(8).priority(.medium)
            $0.trailing.equalToSuperview().inset(24)
        }
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
