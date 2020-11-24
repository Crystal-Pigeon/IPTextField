//
//  IPTextField+UnderlinedTextFieldDelegate.swift
//  IPTextField
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import UIKit

extension IPTextField: UnderlinedTextFieldDelegate {
    
    internal func goToNextTextField(textField: UITextField) {
        for tf in textFields {
            if tf.tag == (textField.tag + 1) {
                tf.becomeFirstResponder()
                return
            }
        }
        textField.resignFirstResponder()
    }
    
    internal func goToPreviousTextField(textField: UITextField) {
        for tf in textFields {
            if tf.tag == (textField.tag - 1) {
                tf.becomeFirstResponder()
                return
            }
        }
        textField.resignFirstResponder()
    }
    
    internal func goBack(textField: UITextField) {
        for tf in textFields {
            if tf.tag == (textField.tag - 1) {
                if !tf.text!.isEmpty {
                    tf.text?.removeLast()
                }
                tf.becomeFirstResponder()
                return
            }
        }
    }
}
