//
//  AppCoordinatorImpl.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinatorImpl {
    private weak var root: UIWindow?
    private let mainViewController: MainContainer!
    
    init(root: UIWindow?) {
        self.root = root
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "Main") as? MainContainer else {
                   fatalError("MainContainer is needed")
               }
        mainViewController = controller
    }
}

extension AppCoordinatorImpl: AppCoordinator {
    func run() {
        root?.rootViewController = mainViewController
        let assembly = AssemblyImpl(root: mainViewController, appCoordinator: self)
        let coordinator = assembly.assembly()
        guard let viewController = coordinator.main else { fatalError() }
        mainViewController.show(viewController, sender: nil)
    }
}
