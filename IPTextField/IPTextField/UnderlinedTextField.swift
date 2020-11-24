//
//  UnderlinedTextField.swift
//  IPTextField
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import UIKit

protocol UnderlinedTextFieldDelegate: AnyObject {
    func goToPreviousTextField(textField: UITextField)
    func goToNextTextField(textField: UITextField)
    func goBack(textField: UITextField)
}

class UnderlinedTextField: UITextField {
    
    // MARK: - Properties
    weak var ipTextField: UnderlinedTextFieldDelegate?
    var bottomBorder = UIView()
    var toolbar: UIToolbar!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    func setup() {
        self.textAlignment = .center
        self.keyboardType = .numberPad
        self.setupBottomBorder()
        self.setupToolbar()
    }
    
    func setupBottomBorder() {
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = .black
        addSubview(bottomBorder)
        
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupToolbar() {
        self.toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        self.toolbar.barStyle = .default
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: self, action: nil)
        fixedSpace.width = 10
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let next = setupToolbarButton(imageName: "next", selector: #selector(nextButtonAction))
        let previous = setupToolbarButton(imageName: "previous", selector: #selector(previousButtonAction))
        
        let items = [previous,fixedSpace, next, flexibleSpace, done]
        self.toolbar.items = items
        self.toolbar.sizeToFit()
        self.inputAccessoryView = self.toolbar
    }
    
    func setupToolbarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        let bundle = Bundle(for: type(of: self))
        button.setImage(UIImage(named:imageName, in:bundle, compatibleWith:nil), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        let barButtonItem: UIBarButtonItem = UIBarButtonItem(customView: button)
        
        let width = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 15)
        width?.isActive = true
        let height = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 15)
        height?.isActive = true
        
        return barButtonItem
    }
    
    // MARK: - Toolbar Actions
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
    
    @objc func nextButtonAction() {
        ipTextField?.goToNextTextField(textField: self)
    }
    
    @objc func previousButtonAction() {
        ipTextField?.goToPreviousTextField(textField: self)
    }
    
    // MARK: - Delete action
    override func deleteBackward() {
        let initialCount = self.text?.count
        super.deleteBackward()
        let countAfterDelete = self.text?.count
        if initialCount == countAfterDelete {
            ipTextField?.goBack(textField: self)
        }
    }
}
