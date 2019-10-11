//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
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
    private var passwordContainer: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var eyeButton: UIButton = UIButton(type: .custom)
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textFieldMargin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        addSubview(passwordContainer)
        passwordContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordContainer.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        passwordContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordContainer.heightAnchor.constraint(equalToConstant: 54).isActive = true
        passwordContainer.layer.borderColor = textFieldBorderColor.cgColor
        passwordContainer.layer.borderWidth = 2
        passwordContainer.layer.cornerRadius = 8
        passwordContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 4).isActive = true
        textField.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 2).isActive = true
        textField.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -2).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: -2).isActive = true
        textField.placeholder = "Enter password here"
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        
        
        let password = textField.text
        guard let aPassword = password else { return }
        
        
        passwordContainer.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 18).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -8).isActive = true
        showHideButton.addTarget(self, action: #selector(changeImage), for: .touchUpInside)

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func changeImage(_ sender: UIButton) {
        
        if textField.isSecureTextEntry == true {
            sender.setImage(#imageLiteral(resourceName: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            sender.setImage(#imageLiteral(resourceName: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
