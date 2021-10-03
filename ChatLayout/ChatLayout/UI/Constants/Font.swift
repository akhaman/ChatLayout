//
//  Font.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 03.10.2021.
//

import UIKit

extension UIFont {

    enum UseCase {
        case navigationTitleLarge
        case navigationTitle
        case navigationButton
        case caption
    }

    static func font(for useCase: UseCase) -> UIFont {
        switch useCase {
        case .navigationTitleLarge:
            return UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: habibiRegular(ofSize: 34))
        case .navigationTitle:
            return UIFontMetrics(forTextStyle: .headline).scaledFont(for: habibiRegular(ofSize: 17))
        case .navigationButton:
            return UIFontMetrics(forTextStyle: .body).scaledFont(for: habibiRegular(ofSize: 17))
        case .caption:
            return UIFontMetrics(forTextStyle: .caption2).scaledFont(for: habibiRegular(ofSize: 14))
        }
    }

    private static func habibiRegular(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Habibi-Regular", size: size) else {
            assertionFailure("Font must exist")
            return .systemFont(ofSize: size)
        }
        return font
    }
}
