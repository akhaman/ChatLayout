//
//  SceneDelegate.swift
//  ChatLayout
//
//  Created by Ruslan Akhmadeev on 02.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController(
            navigationBarClass: NavigationBar.self,
            toolbarClass: nil
        )

        navigationController.pushViewController(ProfileViewController(), animated: false)

        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
