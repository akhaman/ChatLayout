//
//  Fonts.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 03.10.2021.
//

import UIKit

extension UIFont {
    static func font(ofSize size: CGFloat, forTextStyle style: UIFont.TextStyle) -> UIFont {
        UIFontMetrics(forTextStyle: style).scaledFont(for: habibiRegular(ofSize: size))
    }

    private static func habibiRegular(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Habibi-Regular", size: size) else {
            assertionFailure("Failed to load font")
            return .systemFont(ofSize: size)
        }
        return font
    }
}
