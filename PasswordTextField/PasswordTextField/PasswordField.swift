//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength {
    case weak
    case medium
    case strong
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = "" {
        didSet {
            passwordStrength = checkPasswordStrength(password)
        }
    }
    private (set) var passwordStrength: PasswordStrength = .empty {
        didSet {
            setStrengthIndicator(to: passwordStrength)
        }
    }
    
    // internal state
    private var showingPassword = false
    
    // constants
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    // views
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 100)
    }
    
    private func setup() {
        
        backgroundColor = .clear
        
        let container = UIView()
        container.backgroundColor = bgColor
        container.layer.cornerRadius = 6
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.backgroundColor = .clear
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -standardMargin),
        ])
        
        let textFieldContainer = UIView()
        textFieldContainer.layer.borderWidth = 2
        textFieldContainer.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainer.layer.cornerRadius = 7
        container.addSubview(textFieldContainer)
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textFieldContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: standardMargin),
            textFieldContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -standardMargin),
            textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
        ])
        
        textField.delegate = self
        textField.isSecureTextEntry = !showingPassword
        textFieldContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: textFieldMargin * 2),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin),
        ])
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        textFieldContainer.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            showHideButton.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
        ])
        
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = colorViewSize.height / 2
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        ])
        
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = colorViewSize.height / 2
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        ])
        
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = colorViewSize.height / 2
        strongView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        ])
        
        let colorViewStackView = UIStackView()
        colorViewStackView.axis = .horizontal
        colorViewStackView.spacing = 4
        colorViewStackView.addArrangedSubview(weakView)
        colorViewStackView.addArrangedSubview(mediumView)
        colorViewStackView.addArrangedSubview(strongView)
        container.addSubview(colorViewStackView)
        colorViewStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorViewStackView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: 14), // cheat. I can't get centerY = label.centerY
            colorViewStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: standardMargin),
        ])
        
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        container.addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        //strengthDescriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: colorViewStackView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -standardMargin),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc private func showHideButtonTapped() {
        showingPassword.toggle()
        if showingPassword {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    private func checkPasswordStrength(_ potentialPassword: String) -> PasswordStrength {
        switch potentialPassword.count {
        case ...0:
            return .empty
        case 1...9:
            return .weak
        case 10...19:
            return .medium
        default:
            return .strong
        }
    }
    
    private func setStrengthIndicator(to value: PasswordStrength) {
        switch value {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too weak"
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could be stronger"
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        password = textField.text!
        sendActions(for: .valueChanged)
        return false
    }
}
