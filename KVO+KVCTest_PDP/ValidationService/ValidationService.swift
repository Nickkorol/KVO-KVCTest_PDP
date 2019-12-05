//
//  ValidationService.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

protocol ValidationService {
    func checkNameFormat(_ name: String) -> Error?
    func checkBirthdayFormat(_ birthday: String) -> Error?
    func checkEmailFormat(_ email: String) -> Error?
    func checkPhoneFormat(_ phone: String) -> Error?
    func checkLoginFormat(_ login: String) -> Error?
    func checkPasswordFormat(_ password: String) -> Error?
}
