//
//  ValidationError.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

enum ValidationError: Error, LocalizedError {
    case nameFormat(msg: String)
    case birthdayFormat(msg: String)
    case emailFormat(msg: String)
    case phoneFormat(msg: String)
    case loginFormat(msg: String)
    case passwordFormat(msg: String)
    
    var errorDescription: String? {
        switch self {
        case .nameFormat(let msg):
            return msg
        case .birthdayFormat(let msg):
            return msg
        case .emailFormat(let msg):
            return msg
        case .phoneFormat(let msg):
            return msg
        case .loginFormat(let msg):
            return msg
        case .passwordFormat(let msg):
            return msg
        }
    }
}
