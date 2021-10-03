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
        let buttonAppearence = UIBarButtonItemAppearance()
        buttonAppearence.normal.titleTextAttributes = [
            .foregroundColor: UIColor.adaptedFor(light: .pureBlack, dark: .socialWhite)
        ]

        let appearence = UINavigationBarAppearance()
        appearence.buttonAppearance = buttonAppearence
        compactAppearance = appearence
        standardAppearance = appearence
        scrollEdgeAppearance = appearence
        prefersLargeTitles = true
    }
}
