//
//  Coordinator.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var main: UIViewController? { get }
    func run()
}
