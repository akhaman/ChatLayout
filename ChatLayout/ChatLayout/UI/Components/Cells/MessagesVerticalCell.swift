//
//  MessagesVerticalCell.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 04.10.2021.
//

import UIKit

class MessagesVerticalCell: UICollectionViewCell {
    // MARK: Subviews

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleToFill
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 14, forTextStyle: .caption1)
        label.textColor = .adaptedFor(light: .darkGray, dark: .socialWhite)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overriding Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }

    // MARK: Updating

    @discardableResult
    func updated(withImage image: UIImage, name: String) -> Self {
        imageView.image = image
        nameLabel.text = name
        return self
    }

    // MARK: Setup Layout

    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(48)
            $0.top.centerX.equalToSuperview()
        }

        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().priority(.medium)
            $0.centerX.equalTo(imageView)
        }
    }
}
