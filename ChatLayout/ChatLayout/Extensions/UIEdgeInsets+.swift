//
//  UIEdgeInsets+.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

extension UIEdgeInsets {
    init(
        top: CGFloat = .zero,
        left: CGFloat = .zero,
        right: CGFloat = .zero,
        bottom: CGFloat = .zero
    ) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
}
