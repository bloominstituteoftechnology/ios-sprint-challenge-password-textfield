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
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    private let backgroundImageView: UIImageView = UIImageView()
    private let passwordContainerView: UIView = UIView()
    
    
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "SnowTest")
        
        //Enter Password Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.text = "Enter Password"
        titleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        
        //Password Container
        addSubview(passwordContainerView)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        passwordContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordContainerView.layer.borderColor = UIColor.blue.cgColor
        passwordContainerView.layer.borderWidth = 2.0
        passwordContainerView.layer.cornerRadius = 5.0
        
        //Text FIeld
        passwordContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: 8.0).isActive = true
        textField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: 8.0).isActive = true
        textField.trailingAnchor.constraint(equalTo: passwordContainerView.trailingAnchor, constant: -8.0).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -8).isActive = true
        textField.placeholder = "Enter Your Password"

        
        //Button
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 150.0).isActive = true
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        weakView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weakView.topAnchor.constraint(equalToSystemSpacingBelow: passwordContainerView.bottomAnchor, multiplier: 1).isActive = true
        
        weakView.layer.borderWidth = 2.0
        weakView.layer.backgroundColor = weakColor.cgColor
        
        
        
        
        
        
     
        
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
        // TODO: send new text to the determine strength method
        
        
        
        
        return true
    }
}
