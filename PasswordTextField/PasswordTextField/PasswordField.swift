//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // MARK: - Variables
    private (set) var password: String = PasswordStrength.blank.rawValue
    private var weakViewActive = false
    private var mediumViewActive = false
    private var strongViewActive = false
    
    // MARK: - Labels, TextFields, Buttons, Views
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    // MARK: - Custom Sizes
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let viewCornerRadius: CGFloat = 1.0
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    private let strengthDescriptionFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    
    // MARK: - Custom Colors
    private let bgColor = UIColor.white
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    private var textFieldBorderColor = UIColor.gray
    

    // MARK: - Enable Functions
    func enableLabel(named: UILabel) {
        named.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func enableTextField(named: UITextField) {
        named.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func enableButton(named: UIButton) {
        named.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func enableView(named: UIView) {
        named.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Setup
    func setup() {
        
        // Set background color
        backgroundColor = bgColor
        
        // Add title label to view, enable title label, set title label text, uppercase the title label, set title label's font, set title label's color, align title label left
        addSubview(titleLabel)
        enableLabel(named: titleLabel)
        titleLabel.text = "Enter Password"
        titleLabel.text = titleLabel.text?.uppercased()
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.textAlignment = .left
        
        // Add text field to view, enable it, set placeholder text, set border width and corner radius, set color and set to secure entry
        addSubview(textField)
        enableTextField(named: textField)
        textField.placeholder = "Enter your password"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 3
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.isSecureTextEntry = true
        
        // Add showHideButton to view, enable it, set default image to eyes-closed, addTarget (@objc func)
        addSubview(showHideButton)
        enableButton(named: showHideButton)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(passwordVisibility), for: .touchUpInside)
        
        // Add weakView to view, enable weakView, set cornerRadius, set backgroundColor to unused color
        addSubview(weakView)
        enableView(named: weakView)
        weakView.layer.cornerRadius = viewCornerRadius
        weakView.backgroundColor = unusedColor
        
        // Add mediumView to view, enable mediumView, set cornerRadius, set backgroundColor to unused color
        addSubview(mediumView)
        enableView(named: mediumView)
        mediumView.layer.cornerRadius = viewCornerRadius
        mediumView.backgroundColor = unusedColor
        
        // Add strongView to view, enable strongView, set cornerRadius, set backgroundColor to unused color
        addSubview(strongView)
        enableView(named: strongView)
        strongView.layer.cornerRadius = viewCornerRadius
        strongView.backgroundColor = unusedColor
    
        // Add strengthDescriptionLabel to view, enable strengthDescriptionLabel, set font size, set default text to blank
        addSubview(strengthDescriptionLabel)
        enableLabel(named: strengthDescriptionLabel)
        strengthDescriptionLabel.font = strengthDescriptionFont
        strengthDescriptionLabel.text = PasswordStrength.blank.rawValue
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            // textField constraints
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            // showHideButton constraints
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: standardMargin),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -standardMargin),
            showHideButton.widthAnchor.constraint(equalToConstant: 40),
                      
            // weakView constraints
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            weakView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
                 
            
            // mediumView constraints
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 3),
            mediumView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            mediumView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
              
            // strongView constraints
            strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 3),
            strongView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            strongView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            
            // strengthDescriptionLabel constraints
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
    }
    
    // @objc func for #selector in showHideButton.addTarget
    @objc func passwordVisibility() {
        if textField.isSecureTextEntry == true {
            textField.isSecureTextEntry = false
            UIView.animate(withDuration: 0.3) {
                self.showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            }
            
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    // MARK: - Determine Password Strength
    func passwordStrengthDetermined(password: String) {
        
        // Use switch on password.count to animate, change colors, and set active
        switch password.count {
            
        // Empty password case for when text field is empty
        case 0:
            strengthDescriptionLabel.text = PasswordStrength.blank.rawValue
            self.textField.tintColor = self.unusedColor
            self.textFieldBorderColor = self.unusedColor
            
            if weakViewActive == true {

                UIView.animate(withDuration: 0.3) {
                    self.weakView.backgroundColor = self.unusedColor
                    self.textField.layer.borderColor = self.unusedColor.cgColor
                    self.weakView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    
                },
                completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.weakView.transform = .identity
                }, completion: nil)
                
                weakViewActive = false
                mediumViewActive = false
                strongViewActive = false
                weakView.backgroundColor = unusedColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
            }
        
        // Weak password case for 1...9 characters in text field
        case 1...9:
            strengthDescriptionLabel.text = PasswordStrength.tooWeak.rawValue
            if weakViewActive == false {
                strongView.backgroundColor = unusedColor
                mediumView.backgroundColor = unusedColor
                UIView.animate(withDuration: 0.3) {
                    self.textField.tintColor = self.weakColor
                    self.textField.layer.borderColor = self.weakColor.cgColor
                    self.weakView.backgroundColor = self.weakColor
                    self.weakView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.weakColor
                },
                completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.weakView.transform = .identity
                }, completion: nil)
                weakViewActive = true
            }
            
            if mediumViewActive == true {
                UIView.animate(withDuration: 0.3) {
                    self.textField.tintColor = self.weakColor
                    self.mediumView.backgroundColor = self.unusedColor
                    self.textField.layer.borderColor = self.weakColor.cgColor
                    self.mediumView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.weakColor
                },
                completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.mediumView.transform = .identity
                }, completion: nil)
                mediumViewActive = false
                strongViewActive = false
            }
            
        // Medium Password case for 10...19 characters in text field
        case 10...19:
            strengthDescriptionLabel.text = PasswordStrength.couldBeStronger.rawValue
            strengthDescriptionLabel.textColor = mediumColor
            
            if mediumViewActive == false {
                strongView.backgroundColor = unusedColor
                UIView.animate(withDuration: 0.3) {
                    self.textField.layer.borderColor = self.mediumColor.cgColor
                    self.textField.tintColor = self.mediumColor
                    self.mediumView.backgroundColor = self.mediumColor
                    self.mediumView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.mediumColor
                },
                completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.mediumView.transform = .identity
                }, completion: nil)
                mediumViewActive = true
            }
            
            if strongViewActive == true {
                UIView.animate(withDuration: 0.3) {
                    self.textField.layer.borderColor = self.mediumColor.cgColor
                    self.textField.tintColor = self.mediumColor
                    self.strongView.backgroundColor = self.unusedColor
                    self.strongView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.mediumColor
                },
                completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.strongView.transform = .identity
                }, completion: nil)
                strongViewActive = false
            }
        
        // Strong password case (past 19 characters)
        default:
            strengthDescriptionLabel.text = PasswordStrength.strongPassword.rawValue
            strengthDescriptionLabel.textColor = strongColor
            if strongViewActive == false {
                UIView.animate(withDuration: 0.3) {
                    self.textField.layer.borderColor = self.strongColor.cgColor
                    self.textField.tintColor = self.strongColor
                    self.strongView.backgroundColor = self.strongColor
                    self.strongView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.strongColor
                },
                completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.strongView.transform = .identity
                }, completion: nil)
                strongViewActive = true
            }
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
        passwordStrengthDetermined(password: newText)
        password = newText
        return true
    }
}
