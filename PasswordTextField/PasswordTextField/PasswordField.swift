//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit



class PasswordField: UIControl {
    enum PasswordStrength {
        case weak
        case medium
        case strong
    }
    
    // MARK: - Properties
//    private var stackView = UIStackView()
    private var passwordField = UIView()
    private let maxStrength = 10
    private var passwordStrength: PasswordStrength = .weak {
        didSet {
            showPasswordStrength()
        }
    }
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
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
    
    

    // MARK: - Object C functions
    @objc func openEye() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
        @objc func enteredNewPassword() {
            guard let password = textField.text else {
                self.password = ""
                return }
            self.password = password
            textField.resignFirstResponder()
            sendActions(for: .valueChanged)
        }
    // MARK: - Set Up
    func setup() {
        backgroundColor = bgColor
        
        // Setting up title label
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: textFieldMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
        
        // Set up text field
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 3.0
        textField.layer.cornerRadius = 12
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.delegate = self
        textField.backgroundColor = bgColor
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:  textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        textField.addTarget(self, action: #selector(enteredNewPassword), for: .valueChanged)
        
        // Set up hide button
        let leftOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        textField.leftView = leftOverlayView
        textField.leftViewMode = UITextField.ViewMode.always
        let rightOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        rightOverlayView.addSubview(showHideButton)
        textField.rightView = rightOverlayView
        textField.rightViewMode = UITextField.ViewMode.always
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 0, y: 0, width: textFieldContainerHeight, height: textFieldContainerHeight)
        showHideButton.imageView?.contentMode = .scaleAspectFit
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: rightOverlayView.topAnchor).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: rightOverlayView.bottomAnchor).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: rightOverlayView.leadingAnchor, constant: textFieldMargin).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: rightOverlayView.trailingAnchor, constant: -textFieldMargin).isActive = true
        showHideButton.addTarget(self, action: #selector(openEye), for: .touchUpInside)
        
        // Weak view added
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        weakView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -300).isActive = true
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
       // Medium view added
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2).isActive = true
        mediumView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -225).isActive = true
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // Strong view added
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2).isActive = true
        strongView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150).isActive = true
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // Add strength description label
        strengthDescriptionLabel.font = labelFont
//        strengthDescriptionLabel.textColor = labelTextColor
//        strengthDescriptionLabel.lineBreakMode = .byWordWrapping
        strengthDescriptionLabel.numberOfLines = 0
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        // Sets initial strength views to unused until typing begins in the text field
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Updates password strength based on the strength of the password
    private func showPasswordStrength() {
        
        switch passwordStrength {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too weak"
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could be stronger"
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        }
    }
    
    // Switch statement finding new password strength based on the count of characters in the password
    private func newPasswordStrength(for password: String) {
        let count = password.count
        
        switch count {
        case maxStrength...:
            if passwordStrength != .strong {
                passwordStrength = .strong
            }
        case 6...maxStrength:
            if passwordStrength != .medium {
                passwordStrength = .medium
            }
        default:
            if passwordStrength != .weak {
                passwordStrength = .weak
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// MARK: - Extension
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        newPasswordStrength(for: newText)
        return true
    }
    
    // Returns new password and password strength
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enteredNewPassword()
        print("Password: \(password), Password Strength: \(passwordStrength)")
        return true
    }
}
