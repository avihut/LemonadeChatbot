//
//  MessageInputField.swift
//  Chatbot
//
//  Created by Avihu Turzion on 24/03/2020.
//  Copyright © 2020 Avihu Turzion. All rights reserved.
//

import UIKit


protocol MessageInputFieldDelegate: class {
    func userWantsToSend(message: String)
}


final class MessageInputField: XibView {
    enum InputMode {
        case text
        case numbers
        case phone
        case email
        case selection(options: [String])
        case disabled
    }
    
    var inputMode: InputMode = .text {
        didSet {
            updateViews()
        }
    }
    
    var placeholder: String? {
        didSet {}
    }
    
    weak var delegate: MessageInputFieldDelegate?
    
    private var messageTextFieldView: MessageTextField?
    private var messageSelectionFieldView: MessageSelectionField?
    
    override func viewWillInitialize() {
        super.viewWillInitialize()
        updateViews()
    }
    
    func clearText() {}
    
    private func updateViews() {
        switch inputMode {
        case .text:                   switchToMessageTextField(with: .asciiCapable)
        case .numbers:                switchToMessageTextField(with: .numberPad)
        case .phone:                  switchToMessageTextField(with: .phonePad)
        case .email:                  switchToMessageTextField(with: .emailAddress)
        case .selection(let options): switchToMessageSelectionField(with: options)
        case .disabled:               switchToMessageTextField(with: .asciiCapable, disabled: true)
        }
    }
    
    private func switchToMessageTextField(with keyboardType: UIKeyboardType, disabled: Bool = false) {
        guard messageTextFieldView == nil else {
            return
        }
        
        clearInputViews()
        
        let messageTextFieldView = MessageTextField()
        messageTextFieldView.addAndPin(to: self)
        self.messageTextFieldView = messageTextFieldView
    }
    
    private func switchToMessageSelectionField(with options: [String]) {
        guard messageSelectionFieldView == nil else {
            return
        }
        
        clearInputViews()
    }
    
    private func clearInputViews() {
        [messageTextFieldView, messageSelectionFieldView].forEach { view in
            view?.removeFromSuperview()
        }
        
        messageTextFieldView = nil
        messageSelectionFieldView = nil
    }
}
