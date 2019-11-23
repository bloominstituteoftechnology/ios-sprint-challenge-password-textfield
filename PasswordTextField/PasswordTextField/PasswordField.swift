//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit


enum PasswordStrength: String {
    case tooWeak = "Too weak"
    case couldBeStronger = "Could be stronger"
    case strong = "Strong password"
}


class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private(set) var passwordStrength: PasswordStrength? {
        didSet {
            changePasswordStrengthBarColor()
        }
    }
    
    private (set) var password: String = "" {
        didSet {
            determinePasswordStrength()
        }
    }
    
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
    
    private var textFieldContainerView: UIView = UIView()
    private var allElementsStackView: UIStackView = UIStackView()
    private var strengthBarsStackView: UIStackView = UIStackView()
    
    private func setup() {
        layer.cornerRadius = 8
        backgroundColor = bgColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: ADDSubViews
        [titleLabel, textField, strengthBarsStackView].forEach {
            allElementsStackView.addArrangedSubview($0) }
        [weakView, mediumView, strongView, strengthDescriptionLabel].forEach {
            strengthBarsStackView.addArrangedSubview($0)
        }
        
        // MARK: Size and spacing
        textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        allElementsStackView.alignment = .fill
        allElementsStackView.distribution = .fill
        allElementsStackView.axis = .vertical
        
        strengthBarsStackView.alignment = .center
        strengthBarsStackView.distribution = .fill
        strengthBarsStackView.spacing = standardMargin
        
        // MARK: TextField Setup
        
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.rightView = showHideButton
        
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        
        textField.delegate = self
        
        // MARK: Additional Setup (Labels, Stackviews)
        
        // Title Label
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        //StackView
        
        allElementsStackView.spacing = standardMargin
        [allElementsStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        strengthDescriptionLabel.text = "Strength Indicator"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 38)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        // weak view
        
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.layer.cornerRadius = colorViewSize.height / 2
        
        // Medium View
        
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        
        // Strong View
        
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.layer.cornerRadius = colorViewSize.height / 2
        
        NSLayoutConstraint.activate([
            allElementsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
            
            allElementsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -standardMargin),
        
            allElementsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
        
            allElementsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin),
        
            strengthBarsStackView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Show password function
    
    @objc private func showPassword() {
        switch textField.isSecureTextEntry {
        case true:
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        case false:
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    func determinePasswordStrength() {
        if password.count < 10 {
            passwordStrength = .tooWeak
        } else if (10...19).contains(password.count) {
            passwordStrength = .couldBeStronger
        } else {
            passwordStrength = .strong
        }
    }
    
    func changePasswordStrengthBarColor() {
        if let passwordStrength = passwordStrength,
            let password = textField.text,
            !password.isEmpty {
            switch passwordStrength {
            case .tooWeak:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passwordStrength.rawValue
                
            case .couldBeStronger:
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
}


extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        password = newText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField.text {
            password = textField
        }
        
        sendActions(for: .valueChanged)
    }
}
