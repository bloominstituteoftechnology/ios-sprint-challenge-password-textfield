//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum strength: String {
    case weak
    case medium
    case strong
}

class PasswordField: UIControl {
    var showHide: Bool = true
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    var passwordStrength: String = ""
    
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
    
    
    func setup() {
        self.backgroundColor = bgColor
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.text = "ENTER PASSWORD"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = bgColor
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.placeholder = "Enter a password"
        textField.layer.borderWidth = 1
        textField.font = UIFont.monospacedDigitSystemFont(ofSize: textField.font!.pointSize, weight: .medium)
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1).cgColor
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true

        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setTitleColor(UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1), for: .normal)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: standardMargin).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        

        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        weakView.backgroundColor = unusedColor
        
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 8).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        mediumView.backgroundColor = unusedColor
        
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 8).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -28).isActive = true
        strongView.backgroundColor = unusedColor
        
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 8).isActive = true
        strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25
        ).isActive = true
        
        showHideButton.addTarget(self, action: #selector(showHideText), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc private func showHideText() {
        showHide.toggle()
        if showHide {
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        textField.isSecureTextEntry = true
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        wordStrenth(password: oldText)
        return true
    }
    
    
    private func wordStrenth(password: String) {
        
        let length = password.count
        if password.count == 0 {
            strengthDescriptionLabel.text = "Too weak"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            passwordStrength = strength.weak.rawValue
            animateView(which: weakView)
        } else if length == 10 {
            strengthDescriptionLabel.text = "You should do better!"
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            passwordStrength = strength.medium.rawValue
            animateView(which: mediumView)
        } else if length == 20 {
            strengthDescriptionLabel.text = "There you go! Strong!"
            strongView.backgroundColor = strongColor
            passwordStrength = strength.strong.rawValue
            animateView(which: strongView)
        }
    }
    
    func animateView(which strength: UIView) {
        
        strength.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            strength.transform = .identity
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("\(password), with a strength of \(passwordStrength)")
        return true
    }
}
