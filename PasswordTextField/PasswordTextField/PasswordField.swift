//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable
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
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        let titleLabel = UILabel()
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin)
        ])
        
        self.titleLabel = titleLabel

        let textField = UITextField()
        
        textField.isUserInteractionEnabled = true
        textField.borderStyle = .none
        textField.keyboardType = .asciiCapable
        textField.autocorrectionType = .no
        textField.isEnabled = true
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.becomeFirstResponder()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.textField = textField
        
        let showHideButton = UIButton()
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showPasswordToggle), for: .touchUpInside)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.showHideButton = showHideButton
        
        let passwordWrapper = UIView()
        passwordWrapper.translatesAutoresizingMaskIntoConstraints = false

        passwordWrapper.layer.borderWidth = 2
        passwordWrapper.layer.cornerRadius = 12
        passwordWrapper.layer.borderColor = textFieldBorderColor.cgColor
        
        let passwordStackView = UIStackView(arrangedSubviews: [textField, showHideButton])
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordWrapper.addSubview(passwordStackView)
        
        addSubview(passwordWrapper)
        
        NSLayoutConstraint.activate([
            passwordWrapper.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            passwordWrapper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            passwordWrapper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin * -1),
            passwordWrapper.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        NSLayoutConstraint.activate([
            passwordStackView.topAnchor.constraint(equalTo: passwordWrapper.topAnchor),
            passwordStackView.leadingAnchor.constraint(equalTo: passwordWrapper.leadingAnchor, constant: textFieldMargin),
            passwordStackView.trailingAnchor.constraint(equalTo: passwordWrapper.trailingAnchor, constant: textFieldMargin * -1),
            passwordStackView.bottomAnchor.constraint(equalTo: passwordWrapper.bottomAnchor)
        ])
        
        let weakView = UIView()
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.layer.borderWidth = 8
        weakView.layer.cornerRadius = colorViewSize.height / 2
        weakView.layer.borderColor = weakColor.cgColor
        
        self.weakView = weakView
        
        let mediumView = UIView()
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        mediumView.layer.borderWidth = 8
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        mediumView.layer.borderColor = unusedColor.cgColor
        
        self.mediumView = mediumView
        
        let strongView = UIView()
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        strongView.layer.borderWidth = 8
        strongView.layer.cornerRadius = colorViewSize.height / 2
        strongView.layer.borderColor = unusedColor.cgColor
        
        self.strongView = strongView
        
        let strengthStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        strengthStackView.translatesAutoresizingMaskIntoConstraints = false
        strengthStackView.spacing = 2
        addSubview(strengthStackView)
        
        let strengthDescriptionLabel = UILabel()
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
        self.strengthDescriptionLabel = strengthDescriptionLabel
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordWrapper.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strengthStackView.trailingAnchor, constant: standardMargin),
            
            strengthStackView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            strengthStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        determineStrength()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func determineStrength() {
        let length = password.count
        
        if length > 19 {
            strongView.layer.borderColor = strongColor.cgColor
            strengthDescriptionLabel.text = "Strong password"
        } else {
            strongView.layer.borderColor = unusedColor.cgColor
            strengthDescriptionLabel.text = "Could be stronger"
        }
        
        if length > 9 {
            mediumView.layer.borderColor = mediumColor.cgColor
        } else {
            mediumView.layer.borderColor = unusedColor.cgColor
            strengthDescriptionLabel.text = "Too weak"
        }
    }
    
    @objc func showPasswordToggle() {
        let openImage = UIImage(named: "eyes-open")
        let closedImage = UIImage(named: "eyes-closed")
        
        if showHideButton.currentImage == openImage {
            showHideButton.setImage(closedImage, for: .normal)
            textField.isSecureTextEntry = true
        } else {
            showHideButton.setImage(openImage, for: .normal)
            textField.isSecureTextEntry = false
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        determineStrength()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        sendActions(for: .valueChanged)
        
        return true
    }
}
