//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // password secure
    private var passwordSecure: Bool = true
    
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
    private var securityButton: UIButton = UIButton(type: .custom)
    
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textColor = .gray
        titleLabel.text = "PASSWORD:"
        titleLabel.textAlignment = .left
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        
        
        
        addSubview(textField)
        securityButton.isUserInteractionEnabled = true
        securityButton.addTarget(self, action: #selector(self.passwordSecurity), for: .allTouchEvents)
        securityButton.setImage(#imageLiteral(resourceName: "eyes-closed"), for: .normal)
        securityButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        
        //        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        //        textField.layoutMargins = insets
        //        textField.layoutMarginsGuide.leadingAnchor.constraint(equalTo: textField.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        textField.insetsLayoutMarginsFromSafeArea = true
        
        textField.rightView = securityButton
        textField.rightViewMode = .always
        //
        //        let spacerView = UIView(frame:CGRect(x:0, y:0, width: 10, height:10))
        //        textField.leftViewMode = UITextField.ViewMode.always
        //        textField.leftView = spacerView
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = bgColor
        textField.borderStyle = .bezel
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 6
        textField.clipsToBounds = true
        textField.becomeFirstResponder()
        textField.delegate = self
        
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.sizeToFit()
        weakView.backgroundColor = unusedColor
        weakView.tintColor = unusedColor
        
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2).isActive = true
        
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2).isActive = true
        
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.textAlignment = .left
        strengthDescriptionLabel.textColor = .gray
        strengthDescriptionLabel.font = .boldSystemFont(ofSize: 12)
        strengthDescriptionLabel.text = "Password strength: Weak"
        
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 0).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func passwordSecurity(_ sender: UIButton) {
        
        passwordSecure = !passwordSecure
        
        if passwordSecure {
            sender.setImage(#imageLiteral(resourceName: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            sender.setImage(#imageLiteral(resourceName: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
    func passwordStrengthCheck(_ password: String) {
        
        let strong = "Strong"
        let medium = "Medium"
        let weak = "Weak"
        
        let count = password.count
        
        if count < 9 {
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Password strength: \(weak)"
            
        } else if count < 16 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Password strength: \(medium)"
            
            
        } else {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Password strength: \(strong)"
        }
        
    }
    
    private func saveText() {
        
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        
        self.passwordStrengthCheck(newText)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
