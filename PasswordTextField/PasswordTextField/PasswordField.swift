//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

//MARK: - Password Strength Enum
enum PasswordStrength: String {
    case weak = "Too Weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}

class PasswordField: UIControl {
    
    //MARK: - Variables
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
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
    private var textFieldBorder: UIView = UIView()
    
    //MARK: - Setup Function
    func setup() {
        
        // Title Label
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Text Field Border
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorder.layer.borderColor = textFieldBorderColor.cgColor
        textFieldBorder.layer.borderWidth = 1
        textFieldBorder.layer.cornerRadius = 5
        textFieldBorder.backgroundColor = bgColor
        
        addSubview(textFieldBorder)
        
        // Hide Button
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.layer.cornerRadius = 4
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonToggled), for: .touchUpInside)
        addSubview(showHideButton)
        
        // TextField
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.placeholder = "Choose a password:"
        textField.delegate = self
        addSubview(textField)
        
        // Weak View
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = 2
        weakView.layer.backgroundColor = weakColor.cgColor
        addSubview(weakView)
        
        // Medium View
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = 2
        mediumView.layer.backgroundColor = mediumColor.cgColor
        addSubview(mediumView)
        
        //Strong View
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = 2
        strongView.layer.backgroundColor = strongColor.cgColor
        addSubview(strongView)
        
        // Strength Description label
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = passwordStrength.rawValue
        addSubview(strengthDescriptionLabel)
        
        // Constraints
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                     textFieldBorder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                                     textFieldBorder.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                     textFieldBorder.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                                     textFieldBorder.heightAnchor.constraint(equalToConstant: 50),
                                     showHideButton.topAnchor.constraint(equalTo: textFieldBorder.topAnchor),
                                     showHideButton.trailingAnchor.constraint(equalTo: textFieldBorder.trailingAnchor),
                                     showHideButton.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor),
                                     showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
                                     textField.topAnchor.constraint(equalTo: textFieldBorder.topAnchor),
                                     textField.leadingAnchor.constraint(equalTo: textFieldBorder.leadingAnchor, constant: 4),
                                     textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor),
                                     textField.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor),
                                     weakView.topAnchor.constraint(equalTo: textFieldBorder.bottomAnchor, constant: 12),
                                     weakView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                     weakView.heightAnchor.constraint(equalToConstant: 4),
                                     weakView.widthAnchor.constraint(equalToConstant: 50),
                                     mediumView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
                                     mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2),
                                     mediumView.heightAnchor.constraint(equalToConstant: 4),
                                     mediumView.widthAnchor.constraint(equalToConstant: 50),
                                     strongView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
                                     strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2),
                                     strongView.heightAnchor.constraint(equalToConstant: 4),
                                     strongView.widthAnchor.constraint(equalToConstant: 50),
                                     strengthDescriptionLabel.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
                                     strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 6),
                                     strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                                     strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0)
        ])
    }
    //MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func showHideButtonToggled() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    func passwordStrength(for password: String) {
        var strength: PasswordStrength
        
        switch password.count {
        case 0...5:
            strength = PasswordStrength.weak
        case 6...9:
            strength = PasswordStrength.medium
        default:
            strength = PasswordStrength.strong
        }
        
        if passwordStrength != strength {
            updatePasswordStrength(to: strength)
        }
    }
    
    func updatePasswordStrength(to strength: PasswordStrength) {
        passwordStrength = strength
        strengthDescriptionLabel.text = passwordStrength.rawValue
        
        switch passwordStrength {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
}
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        passwordStrength(for: newText)
        return true
    }
}
