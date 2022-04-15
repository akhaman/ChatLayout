//
//  ChatDateHeaderView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 10.10.2021.
//

import UIKit

class ChatDateHeaderView: UICollectionReusableView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 12, forTextStyle: .caption2)
        label.textColor = .lighterGray
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.backgroundColor = ChatAppearance.backgroundColor.withAlphaComponent(0.8)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updated(withTitle title: String) -> Self {
        titleLabel.text = title
        updateLayout()
        return self
    }

    private func setup() {
        addSubview(titleLabel)
    }

    private func updateLayout() {
        titleLabel.sizeToFit()
        titleLabel.frame.size.width += 10
        titleLabel.frame.size.height += 7

        titleLabel.layer.cornerRadius = titleLabel.frame.height / 2
        titleLabel.layer.masksToBounds = true

        titleLabel.frame.origin = CGPoint(
            x: bounds.midX - titleLabel.frame.width / 2,
            y: bounds.maxY - titleLabel.frame.height
        )
    }
}
