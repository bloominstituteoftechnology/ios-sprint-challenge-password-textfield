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
    
    private var wholeView: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var viewForFields: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        // Lay out your subviews here
        
        addSubview(wholeView)
        wholeView.translatesAutoresizingMaskIntoConstraints = false
        wholeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        wholeView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        wholeView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        wholeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        wholeView.layer.backgroundColor = UIColor.red.cgColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.text = "ENTER PASSWORD"
        
        addSubview(viewForFields)
        viewForFields.translatesAutoresizingMaskIntoConstraints = false
        viewForFields.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        viewForFields.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        viewForFields.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        viewForFields.heightAnchor.constraint(equalToConstant: 40).isActive = true
        viewForFields.layer.borderColor = UIColor.darkGray.cgColor
        viewForFields.layer.borderWidth = 0.5
        viewForFields.layer.cornerRadius = 4
        
        viewForFields.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: viewForFields.topAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: viewForFields.trailingAnchor).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: viewForFields.bottomAnchor).isActive = true
        showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor).isActive = true
        showHideButton.layer.cornerRadius = 4
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        
        viewForFields.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.topAnchor.constraint(equalTo: viewForFields.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: viewForFields.leadingAnchor, constant: 4).isActive = true
        textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: viewForFields.bottomAnchor).isActive = true
        textField.isSecureTextEntry = true // this will be changed when the button is tapped.
        textField.placeholder = "Enter here"
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: viewForFields.bottomAnchor, constant: 12).isActive = true
        weakView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weakView.layer.cornerRadius = 2
        weakView.layer.backgroundColor = weakColor.cgColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mediumView.layer.cornerRadius = 2
        mediumView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        strongView.layer.cornerRadius = 2
        strongView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 4).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        strengthDescriptionLabel.text = "Strength here"
        
        
        
        
        
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
