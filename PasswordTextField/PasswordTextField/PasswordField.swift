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
    private var passwordContainerView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        
        // Enter Password Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
        
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        // Password textfield container view
        addSubview(passwordContainerView)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            passwordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            passwordContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
        ])
        
        passwordContainerView.layer.borderColor = textFieldBorderColor.cgColor
        passwordContainerView.layer.borderWidth = 2
        
        // Password textfield
        passwordContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: textFieldMargin),
            textField.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -textFieldMargin),
            textField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -textFieldMargin)
        ])
        
        textField.placeholder = "Password"
        
        // Weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin * 2),
            weakView.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        weakView.backgroundColor = weakColor
        
        // Medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin * 2),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin / 2),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        ])
        
        mediumView.backgroundColor = unusedColor
        
        // Strong view
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strongView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin * 2),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin / 2),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        strongView.backgroundColor = unusedColor
        
        // strengthDescriptionLabel
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor)
        ])
        
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
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
