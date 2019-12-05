//
//  SceneDelegate.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 20/11/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        coordinator = AppCoordinatorImpl(root: window)
        coordinator?.run()
    }

}

