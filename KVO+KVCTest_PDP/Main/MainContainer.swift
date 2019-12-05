//
//  MainContainer.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 05/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

class MainContainer: UINavigationController {
    override func show(_ vc: UIViewController, sender: Any?) {
        pushViewController(vc, animated: true)
    }
}
