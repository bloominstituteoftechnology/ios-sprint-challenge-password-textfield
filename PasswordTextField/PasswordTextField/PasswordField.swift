//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case none = "None"
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
    case epic = "Epic"
}

class PasswordField: UIControl {
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var strength: PasswordStrength = .none
    
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
    
    private var weakThreshold: Int = 1
    private var mediumThreshold: Int = 8
    private var strongThreshold: Int = 16
    private var epicThreshold: Int = 25
    
    private var showPassword: Bool = true {
        didSet {
            textField.isSecureTextEntry = showPassword
            if showPassword {
                showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
            } else {
                showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .normal)
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 160, height: 100)
    }
    
    func setup() {
        // Hiding the background color to the view
        self.backgroundColor = nil
        
        // Label setup
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin)
        ])
        
        // Text Field setup
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 4.5
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = bgColor
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: textFieldMargin - 8),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // Show/Hide Button setup
        textField.rightView = showHideButton // Appends the button to the right
        textField.rightViewMode = .always
        textField.placeholder = "Input password here"
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showHideButton.addTarget(self, action: #selector(showPasswordToggled), for: .touchUpInside)
        // Adding some padding will push the text away from the wall of our text field
        let leftPadding = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 2.0))
        textField.leftView = leftPadding
        textField.leftViewMode = .always
        
        // Password Strength Bars setup
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = mediumColor
        strongView.backgroundColor = strongColor
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        // Strength Description Label setup
        strengthDescriptionLabel.text = "None"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin),
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor)
        ])
        
        // Weak View setup
        weakView.backgroundColor = unusedColor
        
        NSLayoutConstraint.activate([
            weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: standardMargin),
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        // Medium View setup
        mediumView.backgroundColor = unusedColor
        
        NSLayoutConstraint.activate([
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        // Strong View setup
        strongView.backgroundColor = unusedColor
        
        NSLayoutConstraint.activate([
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func passwordAnalyzer(password: String) {
        if password.count < weakThreshold {
            setPasswordSrength(passwordStrength: .none)
        } else if password.count < mediumThreshold {
            setPasswordSrength(passwordStrength: .weak)
        } else if password.count < strongThreshold {
            setPasswordSrength(passwordStrength: .medium)
        } else if password.count < epicThreshold {
            setPasswordSrength(passwordStrength: .strong)
        } else {
            setPasswordSrength(passwordStrength: .epic)
        }
        
        // Animations
        if password.count == weakThreshold {
            doAnimation(objectToAnimate: weakView)
        } else if password.count == mediumThreshold {
            doAnimation(objectToAnimate: mediumView)
        } else if password.count == strongThreshold {
            doAnimation(objectToAnimate: strongView)
        } else if password.count == epicThreshold {
            doAnimation(objectToAnimate: weakView)
            doAnimation(objectToAnimate: mediumView)
            doAnimation(objectToAnimate: strongView)
        }
    }
    
    private func setPasswordSrength(passwordStrength: PasswordStrength) {
        switch strength {
        case .none:
            strength = passwordStrength
            strengthDescriptionLabel.text = "None"
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case .weak:
            strength = passwordStrength
            strengthDescriptionLabel.text = "Weak"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case .medium:
            strength = passwordStrength
            strengthDescriptionLabel.text = "Okay"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case .strong:
            strength = passwordStrength
            strengthDescriptionLabel.text = "Strong"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        case .epic:
            strength = passwordStrength
            strengthDescriptionLabel.text = "EPIC"
            weakView.backgroundColor = .purple
            mediumView.backgroundColor = .purple
            strongView.backgroundColor = .purple
        }
    }
    
    @objc func showPasswordToggled() {
        showPassword.toggle()
    }
    
    func doAnimation(objectToAnimate: UIView) {
        UIView.animate(withDuration: 0.35, animations: {
            objectToAnimate.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (_) in
            objectToAnimate.transform = .identity
        }
    }
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        passwordAnalyzer(password: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        password = text
        sendActions(for: .valueChanged)
        textField.resignFirstResponder() // Hides the keyboard
        return false
    }
    
}
