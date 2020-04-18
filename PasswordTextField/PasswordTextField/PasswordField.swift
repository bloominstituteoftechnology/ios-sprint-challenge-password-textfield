//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "WEAK"
    case medium = "MEDIUM"
    case strong = "STRONG"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var strength: PasswordStrength = .weak
    
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
    
    func setup() {
        // Label
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin).isActive = true
        
        // TextField
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = bgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        // Show Hide Button
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
      
        // Strength Views
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "too weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        weakView.layer.cornerRadius = 2
        mediumView.layer.cornerRadius = 2
        strongView.layer.cornerRadius = 2
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true

        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Functions
    private func passwordStrength(password: String) {
        switch password.count {
        case ..<10:
            statusUpdate(status: .weak)
        case 10...19:
            statusUpdate(status: .medium)
        default:
            statusUpdate(status: .strong)
        }
    }
    
    private func statusUpdate(status: PasswordStrength) {
        switch status {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too Weak"
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could be stronger"
        default:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength(password: newText)
        return true
    }
}
