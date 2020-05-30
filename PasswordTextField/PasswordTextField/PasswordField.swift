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
    private (set) var passwordShow: Bool = false
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
    
    private func updateButtonImage() {
        let showPasswordImage = UIImage(named: "eyes-open.png")
        let hidePasswordImage = UIImage(named: "eyes-closed.png")
        if passwordShow {
            showHideButton.setImage(showPasswordImage, for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(hidePasswordImage, for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
    
    func setup() {
        // Lay out your subviews here
        self.backgroundColor = bgColor
// titleLabel Setup
        
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
// Constraints
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
        ])
// textField Setup
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.isSecureTextEntry = true
        textField.placeholder = "  Password"
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.delegate = self
        addSubview(textField)
// textField Constraints
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
// textField Button
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        showHideButton.addTarget(self, action: #selector(changeShowHideButton), for: .touchUpInside)
        
// Password Strength Views
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = colorViewSize.height / 2
        weakView.backgroundColor = weakColor
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        mediumView.backgroundColor = unusedColor
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = colorViewSize.height / 2
        strongView.backgroundColor = unusedColor
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
        addSubview(weakView)
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        addSubview(mediumView)
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: weakView.topAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2),
            mediumView.bottomAnchor.constraint(equalTo: weakView.bottomAnchor),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        addSubview(strongView)
        NSLayoutConstraint.activate([
            strongView.topAnchor.constraint(equalTo: weakView.topAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2),
            strongView.bottomAnchor.constraint(equalTo: weakView.bottomAnchor),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        addSubview(strengthDescriptionLabel)
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 5),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    @objc func changeShowHideButton() {
        passwordShow.toggle()
        updateButtonImage()
    }
    private func updatePasswordsStrength(strength: PasswordStrength) {
        switch strength {
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
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        }
    }
    
    private func passwordStrength(password: String) {
        switch password.count {
        case 0...9:
            updatePasswordsStrength(strength: .weak)
        case 10...19:
            updatePasswordsStrength(strength: .medium)
        default:
            updatePasswordsStrength(strength: .strong)
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        guard let password = textField.text else { return false }
        print(password)
        return false
    }
}
