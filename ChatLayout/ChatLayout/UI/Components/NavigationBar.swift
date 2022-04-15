//
//  NavigationBar.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 03.10.2021.
//

import UIKit

class NavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let appearance = UINavigationBarAppearance()

        appearance.backgroundColor = .adaptedFor(light: .navBarLight, dark: .navBarDark)
        appearance.setBackIndicatorImage(.backIcon, transitionMaskImage: .backIcon)

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.adaptedFor(light: .primaryBlack, dark: .primaryWhite),
            .font: UIFont.font(ofSize: 34, forTextStyle: .largeTitle)
        ]

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.adaptedFor(light: .primaryBlack, dark: .socialWhite),
            .font: UIFont.font(ofSize: 17, forTextStyle: .headline)
        ]

        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.adaptedFor(light: .pureBlack, dark: .socialWhite),
            .font: UIFont.font(ofSize: 17, forTextStyle: .body)
        ]

        appearance.buttonAppearance = buttonAppearance
        tintColor = .adaptedFor(light: .primaryBlack, dark: .socialWhite)
        compactAppearance = appearance
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        prefersLargeTitles = true
    }
}
