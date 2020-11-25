//
//  ViewController.swift
//  IPTextFieldExamples
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import UIKit
import IPTextField

class ViewController: UIViewController {

    @IBOutlet var textFields: [IPTextField]!
    
    @IBOutlet weak var fontSizeTextField: UITextField!
    @IBOutlet weak var borderWidthTextField: UITextField!
    @IBOutlet weak var cornerRadiusTextField: UITextField!
    @IBOutlet weak var textAlignmentPicker: UIPickerView!
    
    var dataSource = ["left", "center", "right", "justified", "natural"]
    var isLineColor: Bool = false
    var isTextColor: Bool = false
    var isBorderColor: Bool = false
    var textAlignment = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // picker
        self.textAlignmentPicker.delegate = self
        self.textAlignmentPicker.dataSource = self
        
        // tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(disableKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        // text fields
        fontSizeTextField.delegate = self
        fontSizeTextField.keyboardType = .decimalPad
        borderWidthTextField.delegate = self
        borderWidthTextField.keyboardType = .decimalPad
        cornerRadiusTextField.delegate = self
        cornerRadiusTextField.keyboardType = .decimalPad
    }
    
    @objc private func disableKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func setButtonClicked(_ sender: Any) {
        for textField in self.textFields {
            
            if let size = Double(self.fontSizeTextField.text!) {
                textField.font = .systemFont(ofSize: CGFloat(size))
            }
            if let width = Double(self.borderWidthTextField.text!) {
                textField.borderWidth = width
            }
            if let radius = Double(self.cornerRadiusTextField.text!) {
                textField.cornerRadius = radius
            }
            if isLineColor {
                textField.lineColor = UIColor.red
            } else {
                textField.lineColor = .black
            }
            if isTextColor {
                textField.textColor = UIColor.blue
            } else {
                textField.textColor = .black
            }
            if isBorderColor {
                textField.borderColor = UIColor.yellow
            } else {
                textField.borderColor = .black
            }
            textField.textAlignment = NSTextAlignment(rawValue: textAlignment)!
        }
    }
    @IBAction func lineColorChanged(_ sender: UISwitch) {
        if sender.tag == 0 {
            isLineColor = !isLineColor
            return
        }
        else if sender.tag == 1 {
            isTextColor = !isTextColor
            return
        }
        else if sender.tag == 2 {
            isBorderColor = !isBorderColor
            return
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textAlignment = row
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characters = CharacterSet.decimalDigits
        if CharacterSet(charactersIn: string).isSubset(of: characters) {
            return true
        }
        return false
    }
}

