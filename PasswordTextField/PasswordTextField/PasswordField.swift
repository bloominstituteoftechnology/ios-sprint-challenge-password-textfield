//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum passwordStrength: String {
    case weak = "WEAK!"
    case medium = "MEDIUM!"
    case strong = "STRONG!"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: passwordStrength = .weak
    
    // Strengths
    
    private let passwordStrengthWeak: Int = 10
    private let passwordStrengthMedium: Int = 20
    
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

        // Lay out your subviews here
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        // Background Color
        
        backgroundColor = bgColor
        
        // Turn off maskIntoConstraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        // Constrain Values
        NSLayoutConstraint.activate([
            
            // Title Label
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            // Text Field
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // Show Hide Button
            
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
            
            // Strength description
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
                
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
                
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Weak View
            weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                
            weakView.topAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor),
               
                
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            // Medium View
            
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            
            mediumView.topAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor),
            
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            // Strong View
            
           
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
             strongView.topAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
            
            
                
                
            
            
            
            
            
        ])
        
        // Setup Labels & Board objects
                   
            // Title Label
            titleLabel.text = "Enter Password ┴┬┴┤( ͡° ͜ʖ├┬┴┬"
            titleLabel.font = labelFont
            titleLabel.textColor = labelTextColor
                   
            // Text Field
            textField.placeholder = "ENTER PASSWORD"
            titleLabel.font = labelFont
            textField.borderStyle = .bezel
            textField.isSecureTextEntry = true
            textField.isEnabled = true
            textField.delegate = self
        
            // Strength Description
            strengthDescriptionLabel.text = passwordStrength.rawValue
            strengthDescriptionLabel.font = labelFont
            strengthDescriptionLabel.textColor = labelTextColor
        
            // Show/Hide Button
        
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            showHideButton.addTarget(self, action: #selector(hideShowButtonTapped), for: .touchUpInside)
            
            // View Backgrounds
            
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            
        
    }
    
    
   
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func passwordStrength(for stringSize: Int) {
        if stringSize < passwordStrengthWeak {
            passwordStrength = .weak
            strengthDescriptionLabel.text = passwordStrength.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        } else if stringSize > passwordStrengthWeak && stringSize < passwordStrengthMedium {
            passwordStrength = .medium
            strengthDescriptionLabel.text = passwordStrength.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        } else {
            passwordStrength = .strong
            strengthDescriptionLabel.text = passwordStrength.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
    
    @objc func hideShowButtonTapped(sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            print("EyeCantSee")
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            print("EyeCanSee")
        }
            
        }
        
    }

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength(for: newText.count)
        password = newText
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendActions(for: [.valueChanged])
        textField.text = ""
        return true
    }
}
