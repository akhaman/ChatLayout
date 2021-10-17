//
//  MessagesVerticalCell.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 04.10.2021.
//

import UIKit

class MessagesVerticalCell: UICollectionViewCell {

    // MARK: - UI

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lighterGray
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
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Parent Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }

    // MARK: - Setup Layout

    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.heightAnchor.constraint(equalToConstant: 48),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8)
        let bottom = nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        let centerX = nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        bottom.priority = .defaultLow
        
        NSLayoutConstraint.activate([top, bottom, centerX])
    }

    // MARK: - Updating

    @discardableResult
    func updated(withImage image: UIImage, name: String) -> Self {
        imageView.image = image
        nameLabel.text = name
        return self
    }
}
