//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    
    // MARK: - Properties
    
    // Public API - these properties are used to fetch the final password and strength values
    private(set) var password: String = "" { didSet { sendActions(for: .valueChanged) }}
    private(set) var strength: PasswordStrength = .weak {
        didSet {
            if oldValue != strength {
                updateStrengthViews()
            }
        }
    }
    
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSubviews()
    }
    
    
    // MARK: - Private
    
    // Constants
    private let standardMargin: CGFloat = 8.0
    private let textFieldMargin: CGFloat = 6.0
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    private let textFieldHeight: CGFloat = 50.0
    private let textFieldCornerRadius: CGFloat = 6.0
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let textFieldBorderWidth: CGFloat = 2.0
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let colorBarSpacing: CGFloat = 2.0
    
    // Views
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let showHideButton = UIButton()
    private let weakBar = ColorBar(UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1))
    private let mediumBar = ColorBar(UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1))
    private let strongBar = ColorBar(UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1))
    private let strengthDescriptionLabel = UILabel()
    
    private lazy var colorBars = [weakBar, mediumBar, strongBar]
    private lazy var strengthStack = UIStackView(arrangedSubviews: [weakBar, mediumBar, strongBar, strengthDescriptionLabel])
    private lazy var vStack = UIStackView(arrangedSubviews: [titleLabel, textField, strengthStack])

    
    // MARK: - Setup
    
    private func setUpSubviews() {
        backgroundColor = bgColor
        setUpVStack()
        setUpTitleLabel()
        setUpTextField()
        setUpShowHideButton()
        setUpStrengthStack()
    }
    
    private func setUpVStack() {
        addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        vStack.axis = .vertical
        vStack.spacing = standardMargin
        vStack.setCustomSpacing(textFieldMargin, after: titleLabel)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
        ])
    }
    
    private func setUpTitleLabel() {
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
    }
    
    private func setUpTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = textFieldBorderWidth
        textField.layer.cornerRadius = textFieldCornerRadius
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.backgroundColor = .clear
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        textField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setUpShowHideButton() {
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .selected)
        
        showHideButton.widthAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
    }
    
    private func setUpStrengthStack() {
        strengthStack.translatesAutoresizingMaskIntoConstraints = false
        
        strengthStack.alignment = .center
        strengthStack.spacing = colorBarSpacing
        
        weakBar.isEnabled = true
        
        strengthStack.setCustomSpacing(textFieldMargin, after: strongBar)
        
        strengthDescriptionLabel.text = PasswordStrength.weak.description
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
    }
    
    
    // MARK: - Updating
    
    private func updateStrengthViews() {
        strengthDescriptionLabel.text = strength.description
        
        switch strength {
        case .weak:
            weakBar.flare()
            mediumBar.isEnabled = false
            strongBar.isEnabled = false
        case .medium:
            mediumBar.flare()
            mediumBar.isEnabled = true
            strongBar.isEnabled = false
        case .strong:
            strongBar.flare()
            mediumBar.isEnabled = true
            strongBar.isEnabled = true
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func showHideButtonTapped() {
        showHideButton.isSelected.toggle()
        textField.isSecureTextEntry = !showHideButton.isSelected
    }
}


// MARK: - Text Field Delegate

extension PasswordField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let passwordText = textField.text else { return }
        strength = PasswordStrength.strength(for: passwordText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let passwordText = textField.text else { return false }
        password = passwordText
        textField.resignFirstResponder()
        return true
    }
}

