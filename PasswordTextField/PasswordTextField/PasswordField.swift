//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthValue: String {
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong Password"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: StrengthValue = .weak
    
    // Number values for strength of password
    private let strengthValueWeak = 10
    private let strengthValueMedium = 20
    
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
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        // Password textfield container view
        addSubview(passwordContainerView)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.layer.borderColor = textFieldBorderColor.cgColor
        passwordContainerView.layer.borderWidth = 2
        
        passwordContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        passwordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        // Password textfield
        passwordContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        
        textField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -textFieldMargin * 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -textFieldMargin).isActive = true
        textField.delegate = self
        textField.isSecureTextEntry = true

        // Password show/hide button
        passwordContainerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(hideShowButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: textFieldMargin),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            showHideButton.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -textFieldMargin)
        ])
        
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
        
        strengthDescriptionLabel.text = passwordStrength.rawValue
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        // View boundries
        backgroundColor = bgColor
        bottomAnchor.constraint(equalTo: weakView.bottomAnchor, constant: standardMargin).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func determineStrength(for stringSize: Int) {
        if stringSize < strengthValueWeak {
            if passwordStrength != .weak { weakView.performFlare() }
            passwordStrength = .weak
            strengthDescriptionLabel.text = passwordStrength.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor

        } else if stringSize >= strengthValueWeak && stringSize < strengthValueMedium {
            if passwordStrength != .medium { mediumView.performFlare() }
            passwordStrength = .medium
            strengthDescriptionLabel.text = passwordStrength.rawValue
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        } else { // Higher than the medium value
            if passwordStrength != .strong { strongView.performFlare() }
            passwordStrength = .strong
            strengthDescriptionLabel.text = passwordStrength.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
    
    @objc func hideShowButtonTapped(sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        if !textField.isSecureTextEntry {
            let tempString = textField.text
            textField.text = nil
            textField.text = tempString
            textField.font = nil
            textField.font = UIFont.systemFont(ofSize: 14)
        }
        
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
        
        //dasftextField.becomeFirstResponder()
    }
    
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength(for: newText.count)
        password = newText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendActions(for: [.valueChanged])
        return true
    }
}

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.2, y: 1.2) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
