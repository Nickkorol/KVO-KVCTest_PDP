//
//  Input.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 05/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation
@objc enum InputType: Int {
    case fio
    case birthday
    case email
    case phone
    case login
    case password
    
    func fieldName() -> String {
        switch self {
        case .fio:
            return "ФИО"
        case .birthday:
            return "Дата рождения"
        case .email:
            return "Email"
        case .phone:
            return "Номер телефона"
        case .login:
            return "Логин"
        case .password:
            return "Пароль"
        }
    }
}

class Input {
    var fieldType: InputType
    var fieldValue: String = ""
    var isSelected = false
    var error: String?
    
    init(fieldType: InputType) {
        self.fieldType = fieldType
    }
}
