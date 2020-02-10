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
        
        // TextField for password entry
        textFieldBorder.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.topAnchor.constraint(equalTo: textFieldBorder.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: textFieldBorder.leadingAnchor, constant: 4).isActive = true
        textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldBorder.bottomAnchor).isActive = true
        
        backgroundColor = bgColor
        
        
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
