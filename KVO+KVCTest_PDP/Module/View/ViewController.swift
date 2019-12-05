//
//  ViewController.swift
//  KVO+KVCTest_PDP
//
//  Created by Nikita Korolev on 20/11/2019.
//  Copyright © 2019 Никита Королев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let items: [Input] = [
        Input(fieldType: .fio),
        Input(fieldType: .birthday),
        Input(fieldType: .email),
        Input(fieldType: .phone),
        Input(fieldType: .login),
        Input(fieldType: .password)
    ]
    var validationService = ValidationServiceImpl()
    var fieldObservation: NSKeyValueObservation?
    @objc dynamic var inputText: String?
    private var selectedIndex = 0
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private var sendButtonView: UIView!
    @IBOutlet private var sendButton: UIButton!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        let userName = items.filter{ $0.fieldType == .fio }.first?.fieldValue
        let alert = UIAlertController(title: "Success", message: "Data for user \(userName ?? "") is sent", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: ViewInput {
    func updateError(error: String?, forFieldAtIndex index: Int) {
        items[index].error = error
        updateCellAtIndex(index: index)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inputTableViewCell", for: indexPath) as! InputTableViewCell
        cell.delegate = self
        cell.configure(fieldName: items[indexPath.row].fieldType, index: indexPath.row, error: items[indexPath.row].error)
        return cell
    }
    
}

extension ViewController: InputTableViewCellDelegate {
    func editingChanged(index: Int, input: String) {
        if let currentSelectedIndex = self.items.firstIndex(where: { $0.isSelected }) {
            items[currentSelectedIndex].isSelected = false
        }
        items[index].fieldValue = input
        items[index].isSelected = true
        selectedIndex = index
        inputText = input
    }
}

// MARK: - private

private extension ViewController {
    func configure() {
        self.title = "PDP KVO+KVC"
        sendButtonView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        sendButton.isEnabled = false
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        let cellNib = UINib(nibName: "InputTableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "inputTableViewCell")
        configureObserver()
    }
    
    func configureObserver() {
        fieldObservation = observe(\.inputText, options: [.new]) { (vc, change) in
            guard let updatedInputText = change.newValue as? String else { return }
            guard let index = self.items.firstIndex(where: { $0.isSelected }) else { return }
            self.viewModel.checkFieldValueFormat(currentField: self.items[index], text: updatedInputText, index: index)            
        }
    }
    
    func updateCellAtIndex(index: Int) {
        tableView.beginUpdates()
        let indexPath = IndexPath(row: index, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! InputTableViewCell
        cell.configure(fieldName: self.items[index].fieldType, index: index, error: self.items[index].error)
        tableView.endUpdates()
        if items.allSatisfy({ $0.error == nil }) && items.allSatisfy({ !$0.fieldValue.isEmpty }) {
            sendButtonView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            sendButton.isEnabled = true
        } else {
            sendButtonView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            sendButton.isEnabled = false
        }
    }
    
    @objc
    func keyboardWillChange(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = frame.height
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let moveUp = (notification.name == UIResponder.keyboardWillShowNotification)
        bottomConstraint.constant = moveUp ? keyboardHeight - 1 : 0
        let options = UIView.AnimationOptions(rawValue: curve << 16)
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
