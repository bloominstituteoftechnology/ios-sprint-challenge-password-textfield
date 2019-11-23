//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "Too Weak"
    case medium = "Could Be Stronger"
    case strong = "Strong"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private(set) var passwordStrength: PasswordStrength = .weak
    
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
    private var padding: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 15.0))
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        //MARK: SubView Layout
        backgroundColor = bgColor
        layer.cornerRadius = 9.0
        self.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        //MARK: Title Label Set up
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        
        //MARK: Text Field set up
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10.0
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        textField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        
        //MARK: Show Hide Button Set Up
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.imageView?.contentMode = .left
        showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        textField.leftView = padding
        textField.leftViewMode = .always
        
        showHideButton.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.9).isActive = true
        showHideButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        
        //MARK: Password Strength Label Set up
        
        
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
    
    //MARK: Hide or show password function
    @objc private func showPassword() {
        switch textField.isSecureTextEntry{
        case true:
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        case false:
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    //MARK: Required Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: Password Strenght Analyzer
    private func analyzePasswordStrength(for string: String) {
        if string.count < 8 {
            passwordStrength = .weak
        } else if (8...12).contains(string.count) {
            passwordStrength = .medium
        } else {
            passwordStrength = .strong
        }
        
        if let password = textField.text,
            !password.isEmpty {
            switch passwordStrength {
            case .weak:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passwordStrength.rawValue
                
            case .medium:
                weakView.backgroundColor = unusedColor
                mediumView.backgroundColor = mediumColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passwordStrength.rawValue
                
            case .strong:
                weakView.backgroundColor = unusedColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = strongColor
                strengthDescriptionLabel.text = passwordStrength.rawValue
            }
        } else {
            weakView.backgroundColor = unusedColor;
            mediumView.backgroundColor = unusedColor;
            strongView.backgroundColor = unusedColor
        }
    }
    private func dictionaryWord(for text: String) {
         if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: password){
             if passwordStrength == .strong {
                 passwordStrength = .medium
                 weakView.backgroundColor = unusedColor
                 mediumView.backgroundColor = mediumColor
                 strongView.backgroundColor = unusedColor
                 strengthDescriptionLabel.text = "\(PasswordStrength.medium)"
             } else if passwordStrength == .medium {
                 passwordStrength = .weak
                 weakView.backgroundColor = weakColor
                 mediumView.backgroundColor = unusedColor
                 strongView.backgroundColor = unusedColor
                 strengthDescriptionLabel.text = "\(PasswordStrength.weak)"
             }
         }
     }
    
}
//MARK: UITextFieldDelegate
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        analyzePasswordStrength(for: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let password = textField.text, !password.isEmpty{
            self.password = password
            sendActions(for: .valueChanged)
            dictionaryWord(for: password)
        }
        
        return true
    }
    
}
