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
    private let passwordViewContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let passwordViewBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var enterPasswordLabel: UILabel = UILabel()
    private var passwordTextField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var passwordView: UIView = UIView()
    private var passwordIsSeen: Bool = false
    
    func setup() {
        // Lay out your subviews here
        configureEnterPasswordLabel()
        configurePasswordView()
        configurePasswordTextField()
        configureHideButton()
        configureStrengthViews()
        configureStackView()
        
        
    }
    
    func configureEnterPasswordLabel() {
        addSubview(enterPasswordLabel)
        enterPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        enterPasswordLabel.text = "Enter Password"
        enterPasswordLabel.font = labelFont
        enterPasswordLabel.textColor = labelTextColor
        
        NSLayoutConstraint.activate([
            enterPasswordLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            enterPasswordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
        ])
    }
    
    func configurePasswordView() {
        addSubview(passwordView)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.layer.borderColor = passwordViewBorderColor.cgColor
        passwordView.layer.borderWidth = 1
        passwordView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalTo: enterPasswordLabel.bottomAnchor, constant: standardMargin),
            passwordView.leadingAnchor.constraint(equalTo: enterPasswordLabel.leadingAnchor),
            trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: standardMargin),
            passwordView.heightAnchor.constraint(equalToConstant: passwordViewContainerHeight)
        ])
    }
    
    func configurePasswordTextField() {
        passwordView.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        passwordTextField.textColor = passwordViewBorderColor
        passwordTextField.isSecureTextEntry = !passwordIsSeen
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: textFieldMargin),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: textFieldMargin),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: textFieldMargin)
        ])
    }
    
    func configureHideButton() {
        passwordView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            showHideButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            showHideButton.leadingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: textFieldMargin),
            passwordView.trailingAnchor.constraint(equalTo: showHideButton.trailingAnchor, constant: textFieldMargin),
        ])
    }
    
    func configureStrengthViews() {
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = colorViewSize.height / 2.0
        weakView.backgroundColor = weakColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = colorViewSize.height / 2.0
        mediumView.backgroundColor = unusedColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = colorViewSize.height / 2.0
        strongView.backgroundColor = unusedColor
        
        NSLayoutConstraint.activate([
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
    }
    
    func configureStackView() {
        let strengthStackView: UIStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        addSubview(strengthStackView)
        strengthStackView.translatesAutoresizingMaskIntoConstraints = false
        strengthStackView.axis = .horizontal
        strengthStackView.alignment = .center
        strengthStackView.distribution = .fillEqually
        strengthStackView.spacing = 5
        
        
        NSLayoutConstraint.activate([
            strengthStackView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: standardMargin),
            strengthStackView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor)
        ])
    }
    
    @objc func hideButtonTapped() {
        passwordIsSeen.toggle()
        passwordTextField.isSecureTextEntry = !passwordIsSeen
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
