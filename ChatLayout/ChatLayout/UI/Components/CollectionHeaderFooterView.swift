//
//  CollectionHeaderFooterView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 06.10.2021.
//

import UIKit

class CollectionHeaderFooterView: UICollectionReusableView {

    private let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 12, forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .adaptedFor(light: .pureBlack, dark: .lighterGray)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setup() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)
        ])
    }

    @discardableResult
    func updated(with title: String) -> Self {
        titleLabel.text = title
        return self
    }
}
