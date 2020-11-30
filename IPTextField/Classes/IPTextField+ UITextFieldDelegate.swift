//
//  IPTextField+ UITextFieldDelegate.swift
//  IPTextField
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import UIKit

extension IPTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !self.checkIfOnlyDigits(replacementString: string) {
            return false
        }

        guard let oldText = textField.text, let r = Range(range, in: oldText) else { return true }
        let updatedText = oldText.replacingCharacters(in: r, with: string)
        guard let number = Int(updatedText) else { return true } // if number is nil, then deleting
        
        if !self.checkIfNotOver255(number: number, replacementString: string, tag: textField.tag) {
            return false
        }

        if !self.checkIfNotConsecutiveZeros(text: textField.text!, replacementString: string, tag: textField.tag) {
            return false
        }
        
        return true
    }
    
    private func checkIfOnlyDigits(replacementString: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: replacementString)
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        return true
    }
    
    private func checkIfNotConsecutiveZeros(text: String, replacementString: String, tag: Int) -> Bool {
        // if the number 0 is not the first 0
        if text == "0" {
            // if only one character added transfer to next text field
            if replacementString.count == 1 {
                self.switchToNextTextField(currentTag: tag, updatedText: replacementString)
            }
            // if multiple characters added dont change
            return false
        }
        return true
    }
    
    private func checkIfNotOver255(number: Int, replacementString: String, tag: Int) -> Bool {
        if number > 255 {
            // if only one character added transfer to next text field
            if replacementString.count == 1 {
                self.switchToNextTextField(currentTag: tag, updatedText: replacementString)
            }
            // if multiple characters added dont change
            return false
        }
        return true
    }
    
    @objc internal func editingChanged(textField: UITextField) {
        if textField.text == "0" {
            self.switchToNextTextField(currentTag: textField.tag, updatedText: nil)
        }
        if textField.text?.count == 3 {
            self.switchToNextTextField(currentTag: textField.tag, updatedText: nil)
        }
        if textField.text?.count == 2 {
            let number = Int(textField.text!)
            if number != nil && number! > 25 {
                self.switchToNextTextField(currentTag: textField.tag, updatedText: nil)
            }
        }
    }
    
    private func switchToNextTextField(currentTag: Int, updatedText: String?) {
        // if text field has next, switch to next
        for tf in textFields {
            if tf.tag == (currentTag + 1) {
                if updatedText != nil && tf.text == "" {
                    tf.text = updatedText
                }
                tf.becomeFirstResponder()
                return
            }
        }
        // if text field is last, stop editing and notify delegate
        let currentTextField = self.textFields.first { $0.tag == currentTag }
        currentTextField?.resignFirstResponder()
        self.delegate?.insertDone()
    }
}

