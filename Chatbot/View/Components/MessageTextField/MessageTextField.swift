//
//  MessageTextField.swift
//  Chatbot
//
//  Created by Avihu Turzion on 25/03/2020.
//  Copyright © 2020 Avihu Turzion. All rights reserved.
//

import UIKit


protocol MessageTextFieldDelegate: class {
    func process(message: String)
}


final class MessageTextField: XibView {
    @IBOutlet private weak var textFieldView: UITextField!
    @IBOutlet private weak var buttonView: UIButton!
    
    weak var delegate: MessageTextFieldDelegate?
    
    var text: String? {
        set {
            textFieldView.text = newValue
        }
        get {
            return textFieldView.text
        }
    }
    
    var isEnabled: Bool = true {
        didSet {
            textFieldView.isEnabled = isEnabled
            buttonView.isEnabled = isEnabled
        }
    }
    
    var placeholder: String {
        set {
            textFieldView.placeholder = newValue
        }
        get {
            return textFieldView.placeholder ?? ""
        }
    }
    
    var keyboardType: UIKeyboardType {
        set {
            textFieldView.keyboardType = newValue
        }
        get {
            return textFieldView.keyboardType
        }
    }
    
    func clearText() {
        text = ""
    }
    
    @discardableResult override func becomeFirstResponder() -> Bool {
        let isFirstResponder = super.becomeFirstResponder()
        let wasTextFieldFirstResponder = textFieldView.becomeFirstResponder()
        return isFirstResponder && wasTextFieldFirstResponder
    }
    
    @IBAction private func sendButtonTapped() {
        delegate?.process(message: text ?? "")
    }
}
