//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case zero = "enter password"
    case weak = "weak"
    case medium = "could be stronger"
    case strong = "strong password"
}

@IBDesignable
class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
    //  Ben gave us this formatting
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    //  States of the password strength indicators
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
        backgroundColor = bgColor
        // subviews to load on initialization
        
        titleLabel.text = "enter password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        //  use auto-layout to constrain the text field border
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorder.layer.borderColor = textFieldBorderColor.cgColor
        textFieldBorder.layer.borderWidth = 1
        textFieldBorder.layer.cornerRadius = 5
        
        addSubview(textFieldBorder)
        
        NSLayoutConstraint.activate([
            textFieldBorder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textFieldBorder.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textFieldBorder.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            //  used TF container height
            textFieldBorder.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //  use AutoLayout to layout then constrain the show/hide button
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.layer.cornerRadius = 4
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textFieldBorder.topAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textFieldBorder.trailingAnchor),
            showHideButton.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor)
        ])
        
        //  use AutoLayout to set & constrain the textfield
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.placeholder = "choose a password"
        textField.delegate = self
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldBorder.topAnchor),
            textField.leadingAnchor.constraint(equalTo: textFieldBorder.leadingAnchor, constant: 4),
            //  we want the trailing anchor to be eqaul as the distance as the button
            textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor)
        ])
        
        //  weak view
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = 2
        weakView.layer.backgroundColor = weakColor.cgColor
        addSubview(weakView)
        
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textFieldBorder.bottomAnchor, constant: 12),
            weakView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            //  set height to 1/2 of standard margin
            weakView.heightAnchor.constraint(equalToConstant: 4),
            weakView.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        //  medium view
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = 2
        mediumView.backgroundColor = .gray
        addSubview(mediumView)
        
        NSLayoutConstraint.activate([
            mediumView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2),
            mediumView.heightAnchor.constraint(equalToConstant: 4),
            mediumView.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        //  strong view
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = 2
        strongView.backgroundColor = .gray
        addSubview(strongView)
        
        NSLayoutConstraint.activate([
            strongView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2),
            strongView.heightAnchor.constraint(equalToConstant: 4),
            strongView.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        //  build [written] strength label
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = passwordStrength.rawValue
        addSubview(strengthDescriptionLabel)
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: weakView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 6),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -8)
        ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    private func determinePasswordStrength(password: String, oldPassword: String) {
        if password.count == 0 {
            strengthDescriptionLabel.text = "enter password"
            passwordStrength = .weak
            if oldPassword.count == 0 {
                animateColorChange(strength: .zero)
            }
        } else if password.count <= 9 {
            strengthDescriptionLabel.text = "too weak"
            passwordStrength = .weak
            if oldPassword.count > 9 {
                animateColorChange(strength: passwordStrength)
            }
        } else if password.count >= 10 && password.count <= 19 {
            strengthDescriptionLabel.text = "could be stronger"
            passwordStrength = .medium
            if oldPassword.count > 19 || oldPassword.count < 10 {
                animateColorChange(strength: passwordStrength)
            }
        } else if password.count >= 20 {
            strengthDescriptionLabel.text = "strong password"
            passwordStrength = .strong
            if oldPassword.count < 20 {
                animateColorChange(strength: passwordStrength)
            }
        }
    }
    
    private func animateColorChange(strength: PasswordStrength) {
        switch strength {
        case .weak:
            UIView.animate(withDuration: 0.7, animations: {
                self.weakView.transform = CGAffineTransform(scaleX: 1.0, y: 1.8)
            }) { (_) in
                self.weakView.transform = .identity
            }
            self.mediumView.backgroundColor = self.unusedColor
            self.strongView.backgroundColor = self.unusedColor
        case .medium:
            UIView.animate(withDuration: 0.7, animations: {
                self.mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 1.8)
                self.mediumView.backgroundColor = self.mediumColor
                self.strongView.backgroundColor = self.unusedColor
            }) { (_) in
                self.mediumView.transform = .identity
            }
        case .strong:
            UIView.animate(withDuration: 0.7, animations: {
                self.strongView.transform = CGAffineTransform(scaleX: 1.0, y: 1.8)
                self.strongView.backgroundColor = self.strongColor
            }) { (_) in
                self.strongView.transform = .identity
            }
        case .zero:
            UIView.animate(withDuration: 0.5) {
                self.weakView.transform = CGAffineTransform(scaleX: 1.0, y: 1.8)
                self.weakView.backgroundColor = self.unusedColor
                self.mediumView.backgroundColor = self.unusedColor 
            }
        }
    }
    
    @objc private func showHideButtonTapped() {
        switch textField.isSecureTextEntry {
        case true:
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        case false:
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }

}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        determinePasswordStrength(password: newText, oldPassword: oldText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else { return false }
        password = text
        sendActions(for: [.valueChanged])
        return true
    }
    
}
