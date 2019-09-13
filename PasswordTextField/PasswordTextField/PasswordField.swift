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
    private var passwordContainerView: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var eyeImageView: UIImageView = UIImageView()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var isPasswordHidden: Bool = true
    
    @objc func showHideButtonTapped() {
        if isPasswordHidden {
            eyeImageView.image = UIImage(named: "eyes-open")
            textField.isSecureTextEntry = false
        } else {
            eyeImageView.image = UIImage(named: "eyes-closed")
            textField.isSecureTextEntry = true
        }
        isPasswordHidden.toggle()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        // Password Container View
        addSubview(passwordContainerView)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        passwordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        passwordContainerView.layer.borderColor = textFieldBorderColor.cgColor
        passwordContainerView.layer.borderWidth = 2
        passwordContainerView.layer.cornerRadius = 5
        passwordContainerView.backgroundColor = bgColor
        
        // TextField
        passwordContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: standardMargin).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -standardMargin).isActive = true
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        // Eye container
        passwordContainerView.addSubview(eyeImageView)
        eyeImageView.translatesAutoresizingMaskIntoConstraints = false
        eyeImageView.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: standardMargin).isActive = true
        eyeImageView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: standardMargin).isActive = true
        eyeImageView.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -standardMargin).isActive = true
        eyeImageView.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -standardMargin).isActive = true
        eyeImageView.image = UIImage(named: "eyes-closed")

        // eye button
        passwordContainerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: eyeImageView.topAnchor).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: eyeImageView.leadingAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: eyeImageView.trailingAnchor).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: eyeImageView.bottomAnchor).isActive = true
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        // weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin * 2).isActive = true
        weakView.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: standardMargin).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        weakView.backgroundColor = unusedColor
        
        // medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin * 2).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        mediumView.backgroundColor = unusedColor
        
        // strong view
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin * 2).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        strongView.backgroundColor = unusedColor
        
        // strength description
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -standardMargin)
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = " "
        
    }
    
    @objc func animateWeak() {
        UIView.animate(withDuration: 0.5, animations: {
            self.weakView.transform = CGAffineTransform(scaleX: 1, y: 2)
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.weakView.transform = .identity
            })
        }
    }
    
    @objc func animateMedium() {
        UIView.animate(withDuration: 0.5, animations: {
            self.mediumView.transform = CGAffineTransform(scaleX: 1, y: 2)
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.mediumView.transform = .identity
            })
        }
    }
    
    @objc func animateStrong() {
        UIView.animate(withDuration: 0.5, animations: {
            self.strongView.transform = CGAffineTransform(scaleX: 1, y: 2)
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                self.strongView.transform = .identity
            })
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.count < 6 {
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Too weak"
            animateWeak()
        } else if newText.count >= 6 && newText.count < 12 {
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could be stronger"
            animateMedium()
        } else {
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
            animateStrong()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
