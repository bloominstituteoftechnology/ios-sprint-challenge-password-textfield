//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum Strength: String {
    case weak
    case medium
    case strong
}

@IBDesignable
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
    
    private var strength: Strength = .weak
    
    func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textAlignment = .left
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = bgColor
        textField.isSecureTextEntry = true
        textField.setLeftPaddingPoints(7)
        textField.setRightPaddingPoints(27)
        textField.delegate = self
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.bounds.size = colorViewSize
        weakView.layer.backgroundColor = unusedColor.cgColor
        weakView.layer.cornerRadius = 5
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.bounds.size = colorViewSize
        mediumView.layer.backgroundColor = unusedColor.cgColor
        mediumView.layer.cornerRadius = 5
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.bounds.size = colorViewSize
        strongView.layer.backgroundColor = unusedColor.cgColor
        strongView.layer.cornerRadius = 5
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = ""
        strengthDescriptionLabel.textAlignment = .left
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -4),
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 4),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -4),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
            weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 13),
            weakView.widthAnchor.constraint(equalToConstant: 60),
            weakView.heightAnchor.constraint(equalToConstant: 5),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 1),
            mediumView.topAnchor.constraint(equalTo: weakView.topAnchor),
            mediumView.widthAnchor.constraint(equalTo: weakView.widthAnchor),
            mediumView.heightAnchor.constraint(equalTo: weakView.heightAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 1),
            strongView.topAnchor.constraint(equalTo: weakView.topAnchor),
            strongView.widthAnchor.constraint(equalTo: weakView.widthAnchor),
            strongView.heightAnchor.constraint(equalTo: weakView.heightAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 5),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: weakView.topAnchor, constant: -7),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc private func showHidePassword() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    private func checkStrength() {
        switch password.count {
        case 0...9:
            strengthDescriptionLabel.text = "Too weak"
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = unusedColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            strength = .weak
            if password.count == 1 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.weakView.transform = CGAffineTransform(scaleX: 1, y: 1.6)
                }) { (_) in
                    UIView.animate(withDuration: 0.1) {
                        self.weakView.transform = .identity
                    }
                }
            }
        case 10...19:
            strengthDescriptionLabel.text = "Could be stronger"
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = mediumColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            strength = .medium
            if password.count == 10 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.weakView.transform = CGAffineTransform(scaleX: 1, y: 1.6)
                    self.mediumView.transform = CGAffineTransform(scaleX: 1, y: 1.6)
                }) { (_) in
                    UIView.animate(withDuration: 0.1) {
                        self.weakView.transform = .identity
                        self.mediumView.transform = .identity
                    }
                }
            }
        case _ where password.count >= 20:
            strengthDescriptionLabel.text = "Strong password"
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = mediumColor.cgColor
            strongView.layer.backgroundColor = strongColor.cgColor
            strength = .strong
            if password.count == 20 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.weakView.transform = CGAffineTransform(scaleX: 1, y: 1.6)
                    self.mediumView.transform = CGAffineTransform(scaleX: 1, y: 1.6)
                    self.strongView.transform = CGAffineTransform(scaleX: 1, y: 1.6)
                }) { (_) in
                    UIView.animate(withDuration: 0.1) {
                        self.weakView.transform = .identity
                        self.mediumView.transform = .identity
                        self.strongView.transform = .identity
                    }
                }
            }
        default:
            weakView.layer.backgroundColor = unusedColor.cgColor
            mediumView.layer.backgroundColor = unusedColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        checkStrength()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("Password: \(password)")
        print("Password strength: \(strength)")
        return true
    }
}

// Sourced from stackoverflow: https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
