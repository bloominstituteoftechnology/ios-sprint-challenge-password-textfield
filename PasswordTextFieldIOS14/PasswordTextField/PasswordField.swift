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
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        backgroundColor = bgColor
        
        // Title Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        // Constraints
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        // TextField
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = textFieldBorderColor.cgColor
        // Constraints
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1).isActive = true
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: standardMargin).isActive = true
        trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: standardMargin).isActive = true
        
        // Weak View
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = colorViewSize.height / 2
        // Constraints
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        // Medium View
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        // Constraints
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        // Strong View
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = colorViewSize.height / 2
        // Constraints
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        // Strengths Stack View
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)
        // Constraints
        stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        // Strength Description Label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Your password sucks"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        // Constraints
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        bottomAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor, constant: standardMargin).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    @objc func openEyes() {
        textField.isSecureTextEntry.toggle()
        
        if textField.isSecureTextEntry == true {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    func determineStrength(pw: String) {
        switch pw.count {
        case 0...9:
            weakView.backgroundColor = self.weakColor
            self.mediumView.backgroundColor = self.unusedColor
            self.strongView.backgroundColor = self.unusedColor
            strengthDescriptionLabel.text = "Too weak"
        case 10...19:
            UIView.animate(withDuration: 0.4, animations: {
                self.weakView.backgroundColor = self.weakColor
                self.mediumView.backgroundColor = self.mediumColor
                self.strongView.backgroundColor = self.unusedColor
            }, completion: nil)
            strengthDescriptionLabel.text = "Could be stronger"
        case 20...100:
            UIView.animate(withDuration: 0.4, animations: {
                self.weakView.backgroundColor = self.weakColor
                self.mediumView.backgroundColor = self.mediumColor
                self.strongView.backgroundColor = self.strongColor
            }, completion: nil)
            strengthDescriptionLabel.text = "Strong password"
        default:
            UIView.animate(withDuration: 0.4, animations: {
                self.weakView.backgroundColor = self.unusedColor
                self.mediumView.backgroundColor = self.unusedColor
                self.strongView.backgroundColor = self.unusedColor
            }, completion: nil)
            strengthDescriptionLabel.text = ""
        }
        // print(pw)
        // print(strengthDescriptionLabel)
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength(pw: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let password = textField.text, password != "" {
            print(password)
            print("\(strengthDescriptionLabel)")
        }
        textField.resignFirstResponder()
        return true
    }
}
