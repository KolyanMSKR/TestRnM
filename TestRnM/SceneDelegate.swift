//
//  SceneDelegate.swift
//  TestRnM
//
//  Created by Anderen on 01.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var router: CharacterRoutingLogic?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        router = CharacterRouter()
        router?.start(with: windowScene)
    }

}
