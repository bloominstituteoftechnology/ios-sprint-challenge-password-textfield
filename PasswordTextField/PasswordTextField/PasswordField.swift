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
    private (set) var passwordStrength: String = ""
    private var passwordHidden = true
    
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
        backgroundColor = bgColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textAlignment = .left
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "password"
        textField.isEnabled = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = passwordHidden
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(toggleTextVisible), for: .touchUpInside)
        showHideButton.isHidden = false
        showHideButton.isEnabled = true
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = 2
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 2
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 2
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = .systemFont(ofSize: 10)
        strengthDescriptionLabel.text = "Too weak"
        
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
                                     textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
                                     textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
                                     textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
                                     textField.heightAnchor.constraint(equalToConstant: 50),
                                     showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: standardMargin),
                                     showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin),
                                     showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -standardMargin),
                                     showHideButton.widthAnchor.constraint(equalToConstant: 40),
                                     weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
                                     weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
                                     weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
                                     weakView.widthAnchor.constraint(equalToConstant: frame.size.width / 5),
                                     weakView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
                                     mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
                                     mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 3),
                                     mediumView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
                                     mediumView.widthAnchor.constraint(equalToConstant: frame.size.width / 5),
                                     strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
                                     strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
                                     strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 3),
                                     strongView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
                                     strongView.widthAnchor.constraint(equalToConstant: frame.size.width / 5),
                                     strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
                                     strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 20),
                                     strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
                                     strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
                                     strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
                                    ])
    }
    
    @objc func toggleTextVisible() {
        if passwordHidden {
            passwordHidden = false
            textField.isSecureTextEntry = passwordHidden
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            passwordHidden = true
            textField.isSecureTextEntry = passwordHidden
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    func determineStrength(password: String) {
        switch password.count {
        case 0...9:
            strengthDescriptionLabel.text = "Too weak"
            passwordStrength = "Too weak"
        case 10...19:
            strengthDescriptionLabel.text = "Could be stronger"
            passwordStrength = "Could be stronger"
            UIView.animate(withDuration: 0.5) {
                self.mediumView.backgroundColor = self.mediumColor
                self.mediumView.transform = CGAffineTransform(scaleX: 1.05, y: 1.3)
            }
            UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
                self.mediumView.transform = .identity
            }, completion: nil)
            
        default:
            strengthDescriptionLabel.text = "Strong password"
            passwordStrength = "Strong password"
            UIView.animate(withDuration: 0.5) {
                self.strongView.backgroundColor = self.strongColor
                self.strongView.transform = CGAffineTransform(scaleX: 1.05, y: 1.3)
            }
            UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
                self.strongView.transform = .identity
            }, completion: nil)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.delegate = self
        setup()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength(password: newText)
        password = newText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
