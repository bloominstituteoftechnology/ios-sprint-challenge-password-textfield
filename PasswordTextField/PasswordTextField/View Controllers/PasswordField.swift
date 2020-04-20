//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "WEAK"
    case medium = "MEDIUM"
    case strong = "STRONG"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
    
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
    
    private var passwordShow: Bool = false {
        didSet {
            let showPasswordImage = UIImage(named: "eyes-open.png")
            let hidePasswordImage = UIImage(named: "eyes-closed.png")
            textField.isSecureTextEntry = passwordShow
            if passwordShow {
                showHideButton.setImage(showPasswordImage, for: .normal)
                textField.isSecureTextEntry = false
            } else {
                showHideButton.setImage(hidePasswordImage, for: .normal)
                textField.isSecureTextEntry = true
            }
        }
    }
    
    
    func setup() {
        
        //title label
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        //textField formatting
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 2.0
        textField.delegate = self
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        addSubview(textField)
        
        //textField constraints
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        
        //textField Button
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        showHideButton.addTarget(self, action: #selector(changeShowHideButtonImage), for: .touchUpInside)
        
        //strength of password views
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "too weak"
        strengthDescriptionLabel.font = labelFont
        
        weakView.layer.cornerRadius = 3
        mediumView.layer.cornerRadius = 3
        strongView.layer.cornerRadius = 3
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true

        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @objc func changeShowHideButtonImage() {
        passwordShow.toggle()
    }
    
    private func updatePasswordStrength(strength: PasswordStrength) {
        switch strength {
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
    
    private func passwordStrength(password: String) {
        switch password.count {
        case 0...6:
            updatePasswordStrength(strength: .weak)
        case 7...12:
            updatePasswordStrength(strength: .medium)
        default:
            updatePasswordStrength(strength: .strong)
        }
    }
    
    
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength(password: newText)
        return true
    }
}

