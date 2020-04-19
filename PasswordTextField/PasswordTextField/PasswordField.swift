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
    private (set) var strengthDescriptionLabel: UILabel = UILabel()
    private (set) var passwordStrength: PasswordStrength = .weak
    
    enum PasswordStrength: String {
        case weak = "Too weak"
        case  medium = "Could be stronger"
        case strong = "Strong password"
    }
    
    func setup() {
        // Lay out your subviews here
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin)
            
        ])
        
        // Text Field
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.backgroundColor = bgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: textFieldMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // Views
        
        // Weak View
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = 2
        weakView.layer.backgroundColor = weakColor.cgColor
        addSubview(weakView)
        
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12),
            weakView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            weakView.heightAnchor.constraint(equalToConstant: 5),
            weakView.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        
        // Medium View
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = 2
        mediumView.layer.backgroundColor = unusedColor.cgColor
        addSubview(mediumView)
        
        NSLayoutConstraint.activate([
            mediumView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2),
            mediumView.heightAnchor.constraint(equalToConstant: 4),
            mediumView.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        //Strong View
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = 2
        strongView.layer.backgroundColor = unusedColor.cgColor
        addSubview(strongView)
        
        NSLayoutConstraint.activate([
            strongView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2),
            strongView.heightAnchor.constraint(equalToConstant: 4),
            strongView.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        // showHideButton
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor)
            
        ])
        
        // Strength Description label
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        addSubview(strengthDescriptionLabel)
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 8),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
    }
    
    
    @objc func showHideButtonTapped() {
        textField.isSecureTextEntry.toggle()
        
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
        backgroundColor = bgColor
    }
    
    
    func passwordCharacterStrengthViews() {
        
        guard let characterStrength = textField.text?.count else { return }
        
        switch characterStrength {
        case 0...6:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
            weakViews()
            
        case 7...12:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
            mediumViews()
            
            
        default:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
            strongViews()
        }
        
    }
    
    private func weakViews() {
        UIView.animate(withDuration: 0.25, animations: {
            self.weakView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        }) { (_) in
            self.weakView.transform = .identity
        }
    }
    
    private func mediumViews() {
        UIView.animate(withDuration: 0.25, animations: {
            self.mediumView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        }) { (_) in
            self.mediumView.transform = .identity
        }
    }
    
    private func strongViews() {
        UIView.animate(withDuration: 0.25, animations: {
            self.strongView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        }) { (_) in
            self.strongView.transform = .identity
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordCharacterStrengthViews()
        return true
    }
}
