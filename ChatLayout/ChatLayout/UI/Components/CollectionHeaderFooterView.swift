//
//  CollectionHeaderFooterView.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 06.10.2021.
//

import UIKit

class CollectionHeaderFooterView: UICollectionReusableView {
    private let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

    // MARK: Subviews

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(ofSize: 12, forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .adaptedFor(light: .pureBlack, dark: .lighterGray)
        return label
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Updating

    @discardableResult
    func updated(with title: String) -> Self {
        titleLabel.text = title
        return self
    }

    // MARK: Helpers

    private func setup() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
    }
}
