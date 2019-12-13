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
    
    private var passwordViewContainer: UIView = UIView()
    private var eyeImage: UIImageView = UIImageView()
    
    
    func setup() {
        // Lay out your subviews here
        
        //Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 135.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        titleLabel.text = "Enter password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        
        //Password view container
        addSubview(passwordViewContainer)
        passwordViewContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        passwordViewContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordViewContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordViewContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        passwordViewContainer.layer.borderColor = textFieldBorderColor.cgColor
        passwordViewContainer.layer.borderWidth = 3
        passwordViewContainer.backgroundColor = bgColor
        
        
        //TextFeild
        passwordViewContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: passwordViewContainer.topAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: passwordViewContainer.leadingAnchor, constant: standardMargin).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: -standardMargin).isActive = true
        textField.placeholder = "Type in Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        
        // Containter for eye
        passwordViewContainer.addSubview(eyeImage)
        eyeImage.translatesAutoresizingMaskIntoConstraints = false
        eyeImage.topAnchor.constraint(equalTo: passwordViewContainer.topAnchor, constant: standardMargin).isActive = true
        eyeImage.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: standardMargin).isActive = true
        eyeImage.trailingAnchor.constraint(equalTo: passwordViewContainer.trailingAnchor, constant: -standardMargin).isActive = true
        eyeImage.bottomAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: -standardMargin).isActive = true
        eyeImage.image = UIImage(named: "eyes-closed")
        
        
        //eye button
        passwordViewContainer.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: eyeImage.topAnchor).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: eyeImage.leadingAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: eyeImage.trailingAnchor).isActive = true
        //showHideButton.addTarget(self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        
        
        //weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: 16).isActive = true
        weakView.leadingAnchor.constraint(equalTo: passwordViewContainer.leadingAnchor, constant: standardMargin).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        weakView.backgroundColor = unusedColor
        
        //medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: standardMargin * 2 ).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        mediumView.backgroundColor = unusedColor
        
        //strong view
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: standardMargin * 2).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 3.0).isActive = true
        strongView.backgroundColor = unusedColor
        
        // Strenght label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: passwordViewContainer.trailingAnchor, constant: -standardMargin).isActive = true
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = " "
        strengthDescriptionLabel.textColor = labelTextColor
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
