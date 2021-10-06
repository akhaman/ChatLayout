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
        let appearence = UINavigationBarAppearance()

        appearence.backgroundColor = .adaptedFor(light: .navBarLight, dark: .navBarDark)
        appearence.setBackIndicatorImage(.backIcon, transitionMaskImage: .backIcon)

        appearence.largeTitleTextAttributes = [
            .foregroundColor: UIColor.adaptedFor(light: .primaryBlack, dark: .primaryWhite),
            .font: UIFont.font(ofSize: 34, forTextStyle: .largeTitle)
        ]

        appearence.titleTextAttributes = [
            .foregroundColor: UIColor.adaptedFor(light: .primaryBlack, dark: .socialWhite),
            .font: UIFont.font(ofSize: 17, forTextStyle: .headline)
        ]

        let buttonAppearence = UIBarButtonItemAppearance()
        buttonAppearence.normal.titleTextAttributes = [
            .foregroundColor: UIColor.adaptedFor(light: .pureBlack, dark: .socialWhite),
            .font: UIFont.font(ofSize: 17, forTextStyle: .body)
        ]

        appearence.buttonAppearance = buttonAppearence
        tintColor = .adaptedFor(light: .primaryBlack, dark: .socialWhite)
        compactAppearance = appearence
        standardAppearance = appearence
        scrollEdgeAppearance = appearence
        prefersLargeTitles = true
    }
}
