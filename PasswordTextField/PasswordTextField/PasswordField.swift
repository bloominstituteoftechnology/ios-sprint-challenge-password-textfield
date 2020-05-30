//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case noPassword = ""
    case weakPassword = "Too weak"
    case mediumPassword = "Could be stronger"
    case strongPassword = "Strong Password"
}

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
    
    var passwordStrength = ""
    
    //Gives up a condition when set to change our UIButton Image
    private var showPassword: Bool = true {
        didSet{
            textField.isSecureTextEntry = showPassword
            if showPassword{
                showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            } else{
                showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            }
        }
    }
    
    //Function to help us show password using the button
    @objc private func showPasswordFunc(){
        showPassword.toggle()
    }
    
    // Gives our content an area where it can be used
    override var intrinsicContentSize: CGSize{
        return CGSize(width: 170, height: 110)
    }
    
    func setup() {
        //Giving our content view a background
        self.backgroundColor = bgColor
        // Lay out your subviews here
        
        //Enter Password label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin)
        ])
        
        //Password Textfield
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.backgroundColor = bgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 2
        textField.layer.borderColor = textFieldBorderColor.cgColor
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: textFieldMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        //View Passsword Button
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        // Adding a target action for our button
        showHideButton.addTarget(self, action: #selector(showPasswordFunc), for: .touchUpInside)
        addSubview(showHideButton)
        
        // Password Strength Indicator
        //Weak Password
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = 2
        weakView.backgroundColor = unusedColor
        addSubview(weakView)
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 3),
            weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        //Medium Password
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = 2
        mediumView.backgroundColor = unusedColor
        addSubview(mediumView)
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 3),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        //Strong Password
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = 2
        strongView.backgroundColor = unusedColor
        addSubview(strongView)
        NSLayoutConstraint.activate([
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 3),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        //Password Strength Label
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.adjustsFontSizeToFitWidth = true
        addSubview(strengthDescriptionLabel)
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin - 5),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin)
        ])
    }
    
    //Defining our enum and setting up password strength cases
    private func passwordStrength(status: PasswordStrength){
        switch status {
        case .noPassword:
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = status.rawValue
            passwordStrength = "No Password"
        case .weakPassword:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = status.rawValue
            passwordStrength = "Weak Password"
        case .mediumPassword:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = status.rawValue
            passwordStrength = "Medium Password"
        case .strongPassword:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = status.rawValue
            passwordStrength = "Strong Password"
        }
    }
    
    // Checks our password and displays accordingly
    private func passwordStrengthCheck(with password: String){
        if password.count < 1{
            passwordStrength(status: .noPassword)
        } else if password.count <= 7{
            passwordStrength(status: .weakPassword)
            if password.count == 1{
                passwordStrengthAnimation(with: weakView)
            }
        } else if password.count >= 8 && password.count <= 12{
            passwordStrength(status: .mediumPassword)
            if password.count == 8{
                passwordStrengthAnimation(with: mediumView)
            }
        } else {
            passwordStrength(status: .strongPassword)
            if password.count == 13{
                passwordStrengthAnimation(with: strongView)
            }
        }
    }
    
    
    //Password Strength Animation
    private func passwordStrengthAnimation(with view: UIView){
        UIView.animate(withDuration: 0.4, animations: {
            view.transform = CGAffineTransform(scaleX: 1, y: 2)
        }) { (_) in
            UIView.animate(withDuration: 0.2) {
                view.transform = .identity
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        self.passwordStrengthCheck(with: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else { return false }
        password = text
        passwordStrengthCheck(with: password)
        sendActions(for: .valueChanged)
        return false
    }
}
