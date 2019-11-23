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
    private let labelFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    
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
        // Lay out your subviews here
        backgroundColor = bgColor
        layer.cornerRadius = 10.0
        
        //MARK: Title Label Set up
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin)
        ])
        
        //MARK: Text Field set up
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "   Password"
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10.0
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -textFieldMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        //MARK: Show Hide Button Set Up
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.imageView?.contentMode = .left
        showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        textField.leftViewMode = .always
        
        NSLayoutConstraint.activate([
        showHideButton.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.9),
        showHideButton.widthAnchor.constraint(equalToConstant: 40.0)
            
        ])

        //MARK: Password Strength Label Set UP
        
        
        //MARK: WeakView
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = unusedColor
        weakView.layer.cornerRadius = colorViewSize.height / 2
        weakView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: standardMargin * 2).isActive = true
        weakView.leadingAnchor.constraint(equalTo: self.textField.leadingAnchor).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        //MARK: Medium View
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        mediumView.topAnchor.constraint(equalTo: self.weakView.topAnchor).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: self.weakView.trailingAnchor, constant: standardMargin / 2).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        //MARK: Strong View
        addSubview(strongView)
               strongView.translatesAutoresizingMaskIntoConstraints = false
               strongView.backgroundColor = unusedColor
               strongView.layer.cornerRadius = colorViewSize.height / 2
               strongView.topAnchor.constraint(equalTo: self.weakView.topAnchor).isActive = true
               strongView.leadingAnchor.constraint(equalTo: self.mediumView.trailingAnchor, constant: standardMargin / 2).isActive = true
               strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
               strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        //MARK: Strength Label
        strengthDescriptionLabel.text = "Strength Indicator"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: self.strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor).isActive = true

    }
    
    
    
    
    @objc private func showPassword() {
        
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
