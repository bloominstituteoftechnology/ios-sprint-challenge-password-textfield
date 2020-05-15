//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
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
        
        setupTitleLabel()
        
        setupTextField()
        
        setupStrengthViews()
        
        setupStrengthLabel()
        
        setupShowHideButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
    }
    
    private func setupTextField() {
        textField.delegate = self
 
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 5

        textField.isUserInteractionEnabled = true
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textFieldMargin).isActive = true
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
    }
    
    private func setupStrengthViews() {
        weakView.backgroundColor = unusedColor
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 1.5).isActive = true
        
        mediumView.backgroundColor = unusedColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: textFieldMargin).isActive = true
        mediumView.topAnchor.constraint(equalTo: weakView.topAnchor, constant: 0).isActive = true
        
        strongView.backgroundColor = unusedColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: textFieldMargin).isActive = true
        strongView.topAnchor.constraint(equalTo: weakView.topAnchor, constant: 0).isActive = true
    }
    
    private func setupStrengthLabel() {
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "Enter password"
        strengthDescriptionLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        //strengthDescriptionLabel.topAnchor.constraint(equalTo: weakView.topAnchor, constant: 0).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: weakView.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupShowHideButton() {
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.isUserInteractionEnabled = true
        
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin).isActive = true
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: 0).isActive = true
        
        showHideButton.addTarget(self, action: #selector(showHideToggled), for: .touchUpInside)
    }
    
    private func checkPasswordComplexity(_ string: String) -> Bool{
        return UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: string)
    }
    
    private func updatePasswordState(_ string: String) {
        if string.count < 10 {
            
            if mediumView.backgroundColor == mediumColor || weakView.backgroundColor == unusedColor {
                animateStrengthViews(weakView)
            }
            
            strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor

        } else if string.count < 20 {
            
            if strongView.backgroundColor == strongColor || mediumView.backgroundColor == unusedColor {
                animateStrengthViews(mediumView)
            }
            
            strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor

        } else if string.count >= 20 {
            
            if strongView.backgroundColor == unusedColor {
                animateStrengthViews(strongView)
            }
            
            strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor

        }
    }
    
    private func updatePasswordStateWithDictionaryCheck(_ strength: PasswordStrength) {
        switch strength {
        case .weak:
            if mediumView.backgroundColor == mediumColor || weakView.backgroundColor == unusedColor {
                animateStrengthViews(weakView)
            }
            
            strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case .medium:
            if strongView.backgroundColor == strongColor || mediumView.backgroundColor == unusedColor {
                animateStrengthViews(mediumView)
            }
            
            strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case .strong:
            if strongView.backgroundColor == unusedColor {
                animateStrengthViews(strongView)
            }
            
            strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
    
    private func animateStrengthViews(_ view: UIView) {
        UIView.animate(withDuration: 0.1, animations: {
            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.5)
        }) {
            ( _ ) in
            UIView.animate(withDuration: 0.1, animations: {
                view.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc private func showHideToggled() {
        let toggleStatus = textField.isSecureTextEntry
        
        if toggleStatus {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
}

extension PasswordField: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let oldText = textField.text!
//        let stringRange = Range(range, in: oldText)!
//        let newText = oldText.replacingCharacters(in: stringRange, with: string)
//
//        updatePasswordState(newText)
//
//        return true
//    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        if !text.isEmpty {
            let foundInDictionary = checkPasswordComplexity(text)
            
            if text.count < 3 {
                updatePasswordStateWithDictionaryCheck(.weak)
            } else if text.count < 5 {
                if foundInDictionary {
                    updatePasswordStateWithDictionaryCheck(.weak)
                } else {
                    updatePasswordStateWithDictionaryCheck(.medium)
                }
            } else if text.count >= 6 {
                if foundInDictionary {
                    updatePasswordStateWithDictionaryCheck(.medium)
                } else {
                    updatePasswordStateWithDictionaryCheck(.strong)
                }
            }
        }
    }
}
