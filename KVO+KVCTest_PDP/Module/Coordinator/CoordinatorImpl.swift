//
//  CoordinatorImpl.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class CoordinatorImpl {
    weak var root: UIViewController!
    weak var mainViewController: UIViewController!
    weak var appCoordinator: AppCoordinator?

    init(root: UIViewController, mainViewController: UIViewController, appCoordinator: AppCoordinator?) {
        self.root = root
        self.mainViewController = mainViewController
        self.appCoordinator = appCoordinator
    }
}

extension CoordinatorImpl: Coordinator {
    var main: UIViewController? {
        return mainViewController
    }
    
    func run() {
        root.present(mainViewController, animated: true)
    }
}
