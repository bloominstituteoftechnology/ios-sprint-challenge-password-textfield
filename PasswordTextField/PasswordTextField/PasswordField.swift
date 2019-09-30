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
    private (set) var strength: PasswordStrength = .weak {
        didSet {
            self.updateViews(oldValue: oldValue, newValue: self.strength)
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
    private var textField = InsetTextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private let stackView = UIStackView()
    private let mainStackView = UIStackView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
        self.updateViews(oldValue: self.strength, newValue: self.strength)
    }
    
    private func updateViews(oldValue: PasswordStrength, newValue: PasswordStrength) {
        // update the strength label as the user types the password
        self.strengthDescriptionLabel.text = self.strength.description
        
        let didChange: Bool = oldValue != newValue
        
        switch self.strength {
        case .weak:
            self.weakView.backgroundColor = self.weakColor
            self.mediumView.backgroundColor = self.unusedColor
            self.strongView.backgroundColor = self.unusedColor
        case .medium:
            self.weakView.backgroundColor = self.weakColor
            self.mediumView.backgroundColor = self.mediumColor
            self.strongView.backgroundColor = self.unusedColor
            if didChange { self.mediumView.performFlare() }
        case .strong:
            self.weakView.backgroundColor = self.weakColor
            self.mediumView.backgroundColor = self.mediumColor
            self.strongView.backgroundColor = self.strongColor
            if didChange { self.strongView.performFlare() }
        }
    }
    
    private func setup() {
        // Lay out your subviews here

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password".uppercased()
        titleLabel.font = labelFont.withSize(14)
        titleLabel.textColor = UIColor.gray
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 3.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 4.0
        textField.delegate = self
        textField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        let text = "Show"
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.gray
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        showHideButton.setAttributedTitle(attributedString, for: .normal)

        NSLayoutConstraint.activate([
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin)
        ])
        
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(stackView)
        mainStackView.addArrangedSubview(strengthDescriptionLabel)
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = standardMargin
       
        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = standardMargin / 4
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = 4.0

        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = mediumColor
        mediumView.layer.cornerRadius = 4.0
                
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = strongColor
        strongView.layer.cornerRadius = 4.0
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Strong password"
        strengthDescriptionLabel.textColor = UIColor.gray
        strengthDescriptionLabel.font = labelFont.withSize(10)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 8),
            strengthDescriptionLabel.widthAnchor.constraint(equalToConstant: 120),
            
        ])
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        
        self.strength = PasswordStrengthChecker().strength(for: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.password = textField.text ?? ""
        sendActions(for: .valueChanged)
        return true
    }
}

extension UIView {
    // "Flare view" animation
    func performFlare() {
        func flare() { transform = CGAffineTransform(scaleX: 1, y: 1.6) }
        
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.25,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}

private extension PasswordStrength {
    var description: String {
        switch self {
        case .weak:
            return "Too weak"
        case .medium:
            return "Could be stronger"
        case .strong:
            return "Strong password"
        }
    }
}
