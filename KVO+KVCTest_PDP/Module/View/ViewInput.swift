//
//  ViewInput.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

protocol ViewInput: class {
    func updateError(error: String?, forFieldAtIndex index: Int)
}
