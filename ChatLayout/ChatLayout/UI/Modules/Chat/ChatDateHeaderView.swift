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
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateLayout() {
        titleLabel.sizeToFit()

        let titleOrigin = CGPoint(
            x: bounds.midX - titleLabel.frame.width / 2,
            y: bounds.maxY - titleLabel.frame.height
        )

        titleLabel.frame.origin = titleOrigin
    }

    private func setup() {
        addSubview(titleLabel)
    }

    func updated(withTitle title: String) -> Self {
        titleLabel.text = title
        updateLayout()
        return self
    }
}
