//
//  InputTableViewCell.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 20/11/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

protocol InputTableViewCellDelegate: class {
    func editingChanged(index: Int, input: String)
}

class InputTableViewCell: UITableViewCell {
    @IBOutlet private var fieldNameLabel: UILabel!
    @IBOutlet private var inputTextField: UITextField!
    @IBOutlet private var errorLabel: UILabel!
    
    var currentFieldName: InputType?
    var currentIndex = 0
    
    weak var delegate: InputTableViewCellDelegate?
    
    func configure(fieldName: InputType, index: Int, error: String?) {
        if fieldName == .password {
            inputTextField.isSecureTextEntry = true
        }
        currentIndex = index
        currentFieldName = fieldName
        fieldNameLabel.text = fieldName.fieldName()
        if inputTextField.text != "" {
            if error == nil {
                errorLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                errorLabel.text = "Корректно"
            } else {
                errorLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                errorLabel.text = error
            }
        } else {
            errorLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            errorLabel.text = ""
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(index: currentIndex, input: inputTextField.text!)
    }
    
}
