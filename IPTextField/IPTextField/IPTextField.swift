//
//  IPTextField.swift
//  IPTextField
//
//  Created by Mariana Samardzic on 24/11/2020.
//

import UIKit

public protocol IPTextFieldDelegate {
    func insertDone()
}

@IBDesignable public class IPTextField: UIView {
    
    // MARK: - Properties that can be changed in Storyboard
    @IBInspectable var lineColor: UIColor = .black {
        didSet {
            for textField in self.textFields {
                textField.bottomBorder.backgroundColor = lineColor
            }
            for (index, dot) in self.dots.enumerated() {
                if index != 3 {
                    dot.textColor = lineColor
                }
            }
        }
    }
    
    @IBInspectable var textColor: UIColor = .black {
        didSet {
            for textField in self.textFields {
                textField.textColor = textColor
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: Double = 0 {
        didSet {
            if borderWidth <= 4 {
                self.layer.borderWidth = CGFloat(borderWidth)
            } else {
                self.layer.borderWidth = CGFloat(4)
            }
        }
    }
    
    @IBInspectable var cornerRadius: Double = 0 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    // MARK: - Properties that can be changed in code
    public var font: UIFont? {
        didSet {
            for textField in self.textFields {
                textField.font = font
            }
        }
    }
    
    public var textAlignment: NSTextAlignment = .center {
        didSet {
            for textField in self.textFields {
                textField.textAlignment = textAlignment
            }
        }
    }
    
    // MARK: - Delegate
    public var delegate: IPTextFieldDelegate?
    
    // MARK: - UI properties
    internal let textFields = [UnderlinedTextField(), UnderlinedTextField(), UnderlinedTextField(), UnderlinedTextField()]
    private let dots = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    /*
     Content Hugging pulls the view inward.
     Content Hugging Priority -> view resists being made bigger than the intrinsic size.
     Content Resistance pushes the view outward so it does not clip the content.
     Content Resistance Priority -> view resists being made smaller than the intrinsic size.
     */
    
    private func createStack(isLast: Bool = false, index: Int) -> UIStackView {
        // stack
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .bottom
        
        // text field
        let textField = textFields[index]
        textField.tag = index
        textField.ipTextField = self
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged(textField:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .horizontal)
        textField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 999), for: .horizontal)
        
        //textField.adjustsFontSizeToFitWidth = true
        stack.addArrangedSubview(textField)
        
        // label
        let label = dots[index]
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        
        label.text = "."

        if isLast {
            label.textColor = .clear
        }
        stack.addArrangedSubview(label)
        
        return stack
    }
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(createStack(index: 0))
        stack.addArrangedSubview(createStack(index: 1))
        stack.addArrangedSubview(createStack(index: 2))
        stack.addArrangedSubview(createStack(isLast: true, index: 3))
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        self.clipsToBounds = true
        addSubview(mainStack)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    // MARK: - Intrinsic size
    
    // set this variable to true if the view doesn't have intiristic content size
    public override class var requiresConstraintBasedLayout: Bool {
      return false
    }
    
//    // set this variable to desired size
//    public override var intrinsicContentSize: CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//
//    // call this method when custom intrinsic size is being used
//    public override func prepareForInterfaceBuilder() {
//         invalidateIntrinsicContentSize()
//    }
}
