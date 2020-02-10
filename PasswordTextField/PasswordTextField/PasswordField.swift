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
    private let strengthInterval = 10 // Default password strength length
    private var passwordStrength: PasswordValue = .weak { // Default set to .weak
        didSet {
            animatePasswordStrength()
        }
    }
    
    enum PasswordValue: String {
        case weak
        case medium
        case strong
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
    
    private var textFieldBorder: UIView = UIView()
    
    func setup() {
        // Lay out your subviews here
        
        // Title Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.text = "Enter Password"
        
        // Text Field Border
        addSubview(textFieldBorder)
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        textFieldBorder.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldBorder.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldBorder.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldBorder.layer.borderColor = textFieldBorderColor.cgColor
        textFieldBorder.layer.borderWidth = 1
        textFieldBorder.layer.cornerRadius = 5

        // Show/Hide password button
        textFieldBorder.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: textFieldBorder.topAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textFieldBorder.trailingAnchor).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor).isActive = true
        showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor).isActive = true
        showHideButton.layer.cornerRadius = 4
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)

        // TextField for password entry
        textFieldBorder.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.topAnchor.constraint(equalTo: textFieldBorder.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: textFieldBorder.leadingAnchor, constant: 4).isActive = true
        textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor).isActive = true
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter your password"
        
        // Weak strength indicator
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: textFieldBorder.bottomAnchor, constant: 12).isActive = true
        weakView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weakView.layer.cornerRadius = 2
        weakView.layer.backgroundColor = weakColor.cgColor
        
        // Medium strength indicator
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mediumView.layer.cornerRadius = 2
        mediumView.layer.backgroundColor = unusedColor.cgColor
        
        //Strong strength indicator
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        strongView.layer.cornerRadius = 2
        strongView.layer.backgroundColor = unusedColor.cgColor
        
        // Strength Description label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 6).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        strengthDescriptionLabel.text = "Too weak"

        
        backgroundColor = bgColor
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    

    @objc private func showHideButtonTapped() {
        textField.isSecureTextEntry.toggle()
        switch textField.isSecureTextEntry {
        case true: showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        case false: showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
        
    }
    
    //MARK: - TODO: Implement animating password strength indicators
    
    private func determinePasswordStrength(of password: String) {
        let count = password.count
        switch count {
        case strengthInterval...(strengthInterval * 2 - 1): // 10-19
            if passwordStrength != .medium {
                passwordStrength = .medium
            }
        case (strengthInterval * 2)...: // 20+
            if passwordStrength != .strong {
                passwordStrength = .strong
            }
        default:
            if passwordStrength != .weak { //0-9
                passwordStrength = .weak
            }
        }
    }
    
    private func animatePasswordStrength() {
        switch passwordStrength {
        case .weak:
            strengthDescriptionLabel.text = "Too weak"
            mediumView.layer.backgroundColor = unusedColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            UIView.animate(withDuration: 0.5, animations: {
                self.weakView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
            }) { _ in
                UIView.animate(withDuration: 0.5) {
                    self.weakView.transform = .identity
                }
            }
            
        case .medium:
            strengthDescriptionLabel.text = "Could be stronger"
            strongView.layer.backgroundColor = unusedColor.cgColor
            UIView.animate(withDuration: 0.5, animations: {
                self.mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                self.mediumView.layer.backgroundColor = self.mediumColor.cgColor
            }) { _ in
                UIView.animate(withDuration: 0.5) {
                    self.mediumView.transform = .identity
                }
            }
            
        case .strong:
            strengthDescriptionLabel.text = "Strong password"
            mediumView.layer.backgroundColor = mediumColor.cgColor
            UIView.animate(withDuration: 0.5, animations: {
                self.strongView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                self.strongView.layer.backgroundColor = self.strongColor.cgColor
            }) { _ in
                UIView.animate(withDuration: 0.5) {
                    self.strongView.transform = .identity
                }
            }
        }
    }
    
}



extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determinePasswordStrength(of: newText)
        return true
    }
}
