//
//  RoundedButton.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 03.10.2021.
//

import UIKit

class RoundedButton: UIButton {

    private var spacing: CGFloat = .zero

    convenience init(
        title: String,
        image: UIImage? = nil,
        tintColor: UIColor = .adaptedFor(light: .primaryBlack, dark: .primaryWhite)
    ) {
        self.init(type: .system)
        spacing = image == nil ? .zero : 19

        setTitle(title, for: .normal)
        titleLabel?.font = .font(ofSize: 14, forTextStyle: .body)
        titleLabel?.adjustsFontForContentSizeCategory = true

        setImage(image, for: .normal)
        adjustsImageSizeForAccessibilityContentSizeCategory = true

        contentEdgeInsets = UIEdgeInsets(top: 8, left: 32, bottom: 8, right: 32)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(right: spacing / 2)

        self.tintColor = tintColor
        layer.borderWidth = 1
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.adaptedFor(light: .primaryBlack, dark: .lighterGray).cgColor
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + spacing, height: size.height)
    }
}
