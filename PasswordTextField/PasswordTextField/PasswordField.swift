//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength {
    case weak
    case medium
    case strong
}

class PasswordField: UIControl {
    
    // MARK: - Properties
    private var stackView = UIStackView()
    private var passwordField = UIView()
    
    
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
    
    
    
    // MARK: - Stack View
    private func configureStackView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordField.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            stackView.trailingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.trailingAnchor, constant: standardMargin),
            stackView.bottomAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
        ])
        
        let typedPassword = textField.text
        guard let userPassword = typedPassword else { return }
        
        // adding subviews to stack view
        
        //weak view
        stackView.addArrangedSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor, constant: standardMargin).isActive = true
        weakView.trailingAnchor.constraint(equalTo: weakView.leadingAnchor, constant: 50).isActive = true
        weakView.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true
        weakView.bottomAnchor.constraint(equalTo: weakView.topAnchor, constant: 5).isActive = true
        
        //medium view
        stackView.addArrangedSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.leadingAnchor, constant: standardMargin).isActive = true
        mediumView.trailingAnchor.constraint(equalTo: mediumView.leadingAnchor, constant: 50).isActive = true
        mediumView.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true
        mediumView.bottomAnchor.constraint(equalTo: mediumView.topAnchor, constant: 5).isActive = true
        
        //strong view
        stackView.addArrangedSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.leadingAnchor, constant: standardMargin).isActive = true
        strongView.trailingAnchor.constraint(equalTo: strongView.leadingAnchor, constant: 50).isActive = true
        strongView.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true
        strongView.bottomAnchor.constraint(equalTo: strongView.topAnchor, constant: 5).isActive = true
        
        
        //stength description label
        stackView.addArrangedSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.leadingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: strengthDescriptionLabel.leadingAnchor, constant: 50).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true
        strengthDescriptionLabel.bottomAnchor.constraint(equalTo: strengthDescriptionLabel.topAnchor, constant: 5).isActive = true
        
        // strength statement based on number of items in users password
        if userPassword.count > 0 || userPassword.count == 5 {
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Too weak"
        } else if userPassword.count >= 6 || userPassword.count == 10 {
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could be stronger"
        } else if userPassword.count > 10 {
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        } else {
            return
        }
        
    }

    // MARK: - Object C functions
    @objc func openEye() {
        
    }
    
    // MARK: - Set Up
    func setup() {
        // sets backround for view to be clear
        passwordField.backgroundColor = UIColor.clear
        
        
        // Lay out your subviews here
        
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        // 6 points below top of view
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: passwordField.topAnchor, constant: textFieldMargin),
            titleLabel.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor, constant: -standardMargin)
        ])

        
        // 6 points below title label
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant:  textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -standardMargin)
        ])
        

        // 8 points below text field (horizontal stack view containing weak, medium, strong, and password strength)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: textField.topAnchor, constant: standardMargin),
            stackView.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: standardMargin),
            stackView.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin)
        ])
        
        //show hide button added
        textField.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: passwordField.topAnchor, constant: textFieldMargin).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor, constant: standardMargin).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor, constant: -standardMargin).isActive = true
        showHideButton.addTarget(self, action: #selector(openEye), for: .touchUpInside)
        
        
        
        // adding title label and text field to the password view
        passwordField.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}




// MARK: - Extension
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
