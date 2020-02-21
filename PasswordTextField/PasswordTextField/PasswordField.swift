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
    private var backgroundView: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        
        // Label
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
        ])
        
        // Background View
        backgroundView.layer.borderWidth = 1.5
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.borderColor = textFieldBorderColor.cgColor
        backgroundView.backgroundColor = bgColor
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            backgroundView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: standardMargin),
            backgroundView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // Textfield
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: textFieldMargin),
            backgroundView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldMargin)
        ])
        
        // ShowHide Button
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            backgroundView.trailingAnchor.constraint(equalTo: showHideButton.trailingAnchor, constant: textFieldMargin)
        ])
        
        // Weak View
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = unusedColor
        addSubview(weakView)

        NSLayoutConstraint.activate([
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        // Medium View
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        addSubview(mediumView)

        NSLayoutConstraint.activate([
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        // Strong View
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        addSubview(strongView)

        NSLayoutConstraint.activate([
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        //StackView
        let stackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 3
        addSubview(stackView)

        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        // Strength Description Label
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Enter a password"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        addSubview(strengthDescriptionLabel)
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            bottomAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor, constant: standardMargin)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func showHidePassword() {
        textField.isSecureTextEntry.toggle()
        
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    func passwordStrength(_ password: String) {
           switch password.count {
           case 0:
               strengthDescriptionLabel.text = "Enter a password"
               weakView.backgroundColor = unusedColor
               mediumView.backgroundColor = unusedColor
               strongView.backgroundColor = unusedColor
           case 1...10:
               strengthDescriptionLabel.text = "Too weak"
               animations(for: password)
               weakView.backgroundColor = weakColor
               mediumView.backgroundColor = unusedColor
               strongView.backgroundColor = unusedColor
           case 11...20:
               strengthDescriptionLabel.text = "Could be stronger"
               animations(for: password)
               weakView.backgroundColor = weakColor
               mediumView.backgroundColor = mediumColor
               strongView.backgroundColor = unusedColor
           default:
               strengthDescriptionLabel.text = "Strong"
               animations(for: password)
               weakView.backgroundColor = weakColor
               mediumView.backgroundColor = mediumColor
               strongView.backgroundColor = strongColor
           }
       }
       
       func animations(for password: String) {
           if password.count == 1 {
               weakView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
               UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                   self.weakView.transform = .identity
               }, completion: nil)
           } else if password.count == 10 {
               mediumView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
               UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                   self.mediumView.transform = .identity
               }, completion: nil)
           } else if password.count == 20 {
               strongView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
               UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                   self.strongView.transform = .identity
               }, completion: nil)
           }
       }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength(newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let password = textField.text,
            !password.isEmpty else { return false }
        
        self.password = password
        sendActions(for: .valueChanged)
        
        textField.resignFirstResponder()
        return true
    }
}
