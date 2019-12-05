//
//  ValidationServiceImpl.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 04/12/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import Foundation

final class ValidationServiceImpl {
    
}

extension ValidationServiceImpl: ValidationService {
    func checkEmailFormat(_ email: String) -> Error? {
        let emptyEmailError = ValidationError.emailFormat(msg: NSLocalizedString("Заполните поле Адрес электронной почты", comment: ""))
        if email.isEmpty {
            return emptyEmailError
        }
        let error = ValidationError.birthdayFormat(msg: NSLocalizedString("Некорректный формат электронной почты", comment: ""))
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]{2,}\\.[A-Za-z]{2,4}$"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return error }
        let match = regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count))
        if match == nil {
            return error
        }
        return nil
    }
    
    func checkPhoneFormat(_ phone: String) -> Error? {
        let emptyEmailError = ValidationError.phoneFormat(msg: NSLocalizedString("Заполните поле Номер телефона", comment: ""))
        if phone.isEmpty {
            return emptyEmailError
        }
        let error = ValidationError.phoneFormat(msg: NSLocalizedString("Некорректный формат номера телефона", comment: ""))
        let pattern = "^((8|\\+7)[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{7,10}$"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return error }
        let match = regex.firstMatch(in: phone, options: [], range: NSRange(location: 0, length: phone.count))
        if match == nil {
            return error
        }
        return nil
    }
    
    func checkLoginFormat(_ login: String) -> Error? {
        let error = ValidationError.loginFormat(msg: NSLocalizedString("Логин - обязательное поле", comment: ""))
        if login.isEmpty {
            return error
        } else if login.count < 5 {
            return ValidationError.loginFormat(msg: NSLocalizedString("Логин должен содержать хотя бы 5 символов", comment: ""))
        } else {
            return nil
        }
    }
    
    func checkPasswordFormat(_ password: String) -> Error? {
        let message = NSLocalizedString("Пароль должен быть больше 8 символов и содержать минимум 1 цифру, 1 строчную и 1 заглавную букву", comment: "")
        let error = ValidationError.passwordFormat(msg: message)
        let pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]*).{8,}$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return error }
        let match = regex.firstMatch(in: password, options: [], range: NSRange(location: 0, length: password.count))
        if match == nil {
            return error
        }
        return nil
    }
    
    func checkBirthdayFormat(_ birthday: String) -> Error? {
        let emptyBirthdayError = ValidationError.birthdayFormat(msg: NSLocalizedString("Заполните поле Дата рождения", comment: ""))
        if birthday.isEmpty {
            return emptyBirthdayError
        }
        let error = ValidationError.birthdayFormat(msg: NSLocalizedString("Формат даты рождения должен быть дд.мм.гггг", comment: ""))
        let pattern = "([0-2]\\d|3[01])\\.(0\\d|1[012])\\.(\\d{4}$)"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else { return error }
        let match = regex.firstMatch(in: birthday, options: [], range: NSRange(location: 0, length: birthday.count))
        if match == nil {
            return error
        }
        return nil
    }
    
    func checkNameFormat(_ name: String) -> Error? {
        let error = ValidationError.nameFormat(msg: NSLocalizedString("ФИО - обязательное поле", comment: ""))
        if name.isEmpty {
            return error
        } else if name.count < 10 {
            return ValidationError.nameFormat(msg: NSLocalizedString("ФИО должно содержать хотя бы 10 символов", comment: ""))
        } else {
            return nil
        }
    }
}
