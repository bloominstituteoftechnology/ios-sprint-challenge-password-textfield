//
//  PasswordField.swift
//  PasswordTextField
//
//  Sal Amer v2
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit


enum PassStrengthColor: String {
    case none = "No Password"
    case weak = "Weak Password"
    case medium = "Could Be Stronger"
    case strong = "Strong Password"
}
//@IBDesignable - not working
class PasswordFields: UIControl {
        
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = "" {
        didSet{
            passwordString()
        }
    }
    
    private (set) var passStrength: PassStrengthColor? {
        didSet {
            passStrengthBarColorChange()
        }
    }
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var passStrengthHorigzontalView: UIStackView = UIStackView()
    private var textlabelsStack: UIStackView = UIStackView()
    
    func setup() {
        // Lay out your subviews here
        layer.cornerRadius = 10
        backgroundColor = bgColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Subviews USING Stackview
        
        [titleLabel, textField, passStrengthHorigzontalView].forEach {
            textlabelsStack.addArrangedSubview($0)
        }
        [weakView, mediumView, strongView, strengthDescriptionLabel].forEach {
            passStrengthHorigzontalView.addArrangedSubview($0)
            }
        
        // Spacing
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        passStrengthHorigzontalView.alignment = .center
        passStrengthHorigzontalView.distribution = .fillProportionally
        passStrengthHorigzontalView.spacing = standardMargin
        textlabelsStack.alignment = .fill
        textlabelsStack.distribution = .fill
        textlabelsStack.axis = .vertical
        
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 4
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.rightView = showHideButton
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        textlabelsStack.spacing = standardMargin
        [textlabelsStack].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        strengthDescriptionLabel.text = "Strength Indicator"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.layer.cornerRadius = colorViewSize.height / 2
        
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.layer.cornerRadius = colorViewSize.height / 2
        
        textlabelsStack.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        textlabelsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin).isActive = true
        textlabelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        textlabelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        
        

//        //Title Label & constraints
//        addSubview(titleLabel)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.text = "ENTER PASSWORD"
//        titleLabel.font = labelFont
//        titleLabel.textColor = labelTextColor
//        titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
//
//        // textField
//        addSubview(textField)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Enter Password"
//        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
//        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: Functions
    @objc func showPassword() {
        switch textField.isSecureTextEntry {
        case true:
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        case false:
             textField.isSecureTextEntry = true
             showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    func passwordString() {
        if password.count == 0 {
            passStrength = .none
        } else if password.count < 6 {
            passStrength = .weak
        } else if password.count < 11 {
            passStrength = .medium
        } else {
            passStrength = .strong
        }
        
    }
    
    func passStrengthBarColorChange() {
        if let passStrength = passStrength,
            let password = textField.text,
            !password.isEmpty {
            switch passStrength {
            case .none:
                weakView.backgroundColor = unusedColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passStrength.rawValue
                
            case .weak:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passStrength.rawValue
                weakView.performFlare()
            
            case .medium:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = mediumColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passStrength.rawValue
                mediumView.performFlare()
                
            case .strong:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = mediumColor
                strongView.backgroundColor = strongColor
                strengthDescriptionLabel.text = passStrength.rawValue
                strongView.performFlare()
            }
        } else {
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        }
        
    }
}

extension PasswordFields: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        password = newText
        return true
    }
}

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.3, y: 1.3) }
    func unflare() { transform = .identity }

    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
