//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by brian vilchez on 9/13/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class PasswordField: UIView {

    // MARK: - Properties
    private (set) var password: String = ""
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var passwordContainerView: UIView = UIView()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    //MARK: - PropertyColors
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    func setup() {
        // Lay out your subviews here
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        titleLabel.text = "Enter Password:"
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        titleLabel.textColor = UIColor.black
        
        addSubview(passwordContainerView)
        passwordContainerView.layer.borderColor = textFieldBorderColor.cgColor
        passwordContainerView.layer.borderWidth = 2
        passwordContainerView.layer.cornerRadius = 10
        passwordContainerView.isUserInteractionEnabled = true
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1).isActive = true
        passwordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "enter password."
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = true
        textField.delegate = self
        textField.leadingAnchor.constraint(equalTo:passwordContainerView.leadingAnchor,constant: 8 ).isActive = true
        textField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: 10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        passwordContainerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.isUserInteractionEnabled = true
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        showHideButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 3).isActive = true
        showHideButton.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: 15).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -20 ).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -5)
        
        addSubview(weakView)
        weakView.layer.borderWidth = 1
        weakView.layer.cornerRadius = 5
        weakView.backgroundColor = unusedColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalToSystemSpacingBelow: passwordContainerView.bottomAnchor, multiplier: 1).isActive = true
        weakView.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor,constant: 8).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(mediumView)
        mediumView.layer.borderWidth = 1
        mediumView.layer.cornerRadius = 5
        mediumView.backgroundColor = unusedColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalToSystemSpacingBelow: passwordContainerView.bottomAnchor, multiplier: 1).isActive = true
        mediumView.leadingAnchor.constraint(equalToSystemSpacingAfter: weakView.trailingAnchor, multiplier: 0.5).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(strongView)
        strongView.layer.borderWidth = 1
        strongView.layer.cornerRadius = 5
        strongView.backgroundColor = unusedColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalToSystemSpacingBelow: passwordContainerView.bottomAnchor, multiplier: 1).isActive = true
        strongView.leadingAnchor.constraint(equalToSystemSpacingAfter: mediumView.trailingAnchor, multiplier: 0.5).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.text = "could be stronger"
        strengthDescriptionLabel.textColor = .black
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: strongView.trailingAnchor, multiplier: 1).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: passwordContainerView.bottomAnchor, multiplier: 0.5).isActive = true
        
    }
    private func determineStrength(for password: String) {
        
        switch password.count {
        case 0:
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "create password"
        case 1...9:
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "password to short"
            
        case 10...19:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "could be stronger"
            
        case 20...50:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "password is strong."
        default:
            break
        }
    }
    
    @objc private func showHideButtonTapped(_ sender: UIButton) {
        
        showHideButton.isSelected = !showHideButton.isSelected
        if showHideButton.isSelected == true {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(UIImage(named:"eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }

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
        password = newText
        self.determineStrength(for: password)
        print(newText)
        return true
    }
}
