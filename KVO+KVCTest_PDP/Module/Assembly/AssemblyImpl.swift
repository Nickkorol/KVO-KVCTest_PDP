//
//  AssemblyImpl.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class AssemblyImpl: Assembly {
    
    private let root: UIViewController!
    private weak var appCoordinator: AppCoordinator?

    init(root: UIViewController, appCoordinator: AppCoordinator?) {
        self.root = root
        self.appCoordinator = appCoordinator
    }
    
    func assembly() -> Coordinator {
        let storyboard = UIStoryboard(name: "View", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
                   fatalError("ViewController is needed")
               }
        let viewModel = ViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = CoordinatorImpl(root: root, mainViewController: controller, appCoordinator: appCoordinator)

        let validationService = ValidationServiceImpl()

        viewModel.coordinator = coordinator
        viewModel.view = controller
        viewModel.validationService = validationService

        return coordinator
    }
}
