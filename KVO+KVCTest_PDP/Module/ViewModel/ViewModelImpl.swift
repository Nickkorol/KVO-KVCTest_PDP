//
//  ViewModelImpl.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

final class ViewModelImpl: ViewModel {
    
    var coordinator: Coordinator!
    weak var view: ViewInput?
    var validationService: ValidationService!
    
    func checkFieldValueFormat(currentField: Input, text: String, index: Int) {
        var error = self.validationService.checkNameFormat(text)
        switch currentField.fieldType {
        case .fio:
            error = self.validationService.checkNameFormat(text)
            break
        case .birthday:
            error = self.validationService.checkBirthdayFormat(text)
            break
        case .email:
            error = self.validationService.checkEmailFormat(text)
            break
        case .phone:
            error = self.validationService.checkPhoneFormat(text)
            break
        case .login:
            error = self.validationService.checkLoginFormat(text)
            break
        case .password:
            error = self.validationService.checkPasswordFormat(text)
            break
        default:
            break
        }
        view?.updateError(error: error?.localizedDescription, forFieldAtIndex: index)
    }
}
