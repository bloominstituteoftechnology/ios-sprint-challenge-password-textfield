//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // MARK: - Password Strength Enum
    enum PasswordStrength: String {
        case weak = "Too weak"
        case medium = "Could be stronger"
        case strong = "Strong password"
    }
    
    // MARK: - Properties
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var strength: PasswordStrength = .weak

    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 160, height: 160)
    }
    
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
    
    // MARK: - Functions
    
    private func setup() {
        // Lay out your subviews here
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 10.0
        
        // Label
        titleLabel.text = "ENTER PASSWORD:"
        titleLabel.textColor = labelTextColor
        titleLabel.textAlignment = .left
        titleLabel.font = labelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Button
        showHideButton.setImage(UIImage.init(named: "eyes-closed"), for: .normal)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        showHideButton.imageView?.contentMode = .left

        // Text field
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always

        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        // Color views and strength label
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        
        // Constraints
        NSLayoutConstraint.activate([
        
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin),
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: textFieldMargin),
            
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: weakView.topAnchor),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin)
            
        
        ])
        
    }
    
    private func valueChanged(newValue: String) {
        
        guard password == textField.text else { return }
        
        if password.count <= 9 {
            strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        } else if password.count >= 10,
            password.count <= 19 {
            strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        } else if password.count >= 20 {
            strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
        
    }
    
    private func returnKeyTapped() {
        print(textField.text ?? "There is no password in the text field.")
        
        guard let text = textField.text else { return }
        valueChanged(newValue: text)
        
    }
    
    @objc private func showHideButtonTapped() {
        if textField.isSecureTextEntry == true {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage.init(named:"eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage.init(named: "eyes-closed"), for: .normal)
        }     
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
}

// MARK: - Text Field Extension
extension PasswordField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        valueChanged(newValue: text)
        sendActions(for: .valueChanged)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        valueChanged(newValue: text)
        sendActions(for: .valueChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        valueChanged(newValue: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        password = text
        
        textField.resignFirstResponder()
        returnKeyTapped()
        
        sendActions(for: .valueChanged)
        return true
    }
}
