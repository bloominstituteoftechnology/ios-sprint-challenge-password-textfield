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
    
    func setup() {
        // Lay out your subviews here
        
        // Set up titleLabel
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "ENTER PASSWORD:"
        titleLabel.font = labelFont
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100 + standardMargin).isActive = true
        
        // Create and set up textFieldContainer
        let textFieldContainer = UIView()
        
        addSubview(textFieldContainer)
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textFieldContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textFieldContainer.layer.cornerRadius = 8
        textFieldContainer.layer.borderWidth = 2
        textFieldContainer.layer.borderColor = textFieldBorderColor.cgColor
        
        
        textFieldContainer.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        showHideButton.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -standardMargin).isActive = true
        showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: standardMargin).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -standardMargin).isActive = true
        showHideButton.widthAnchor.constraint(equalToConstant: textFieldContainerHeight - standardMargin * 2).isActive = true
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideTapped), for: .touchUpInside)
        
        
        // Set up textField in textFieldContainer
        textFieldContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: standardMargin).isActive = true
        textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor, constant: -standardMargin).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -standardMargin).isActive = true
        
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = true
//        textField.backgroundColor = .lightGray
        textField.placeholder = "Password"
        
        
        
        // Set up StrengthLabels and StrengthLabel
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.backgroundColor = unusedColor
        weakView.layer.cornerRadius = 3
        
        weakView.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor).isActive = true
        weakView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 3
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 1).isActive = true
        mediumView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 3
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 1).isActive = true
        strongView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 5).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor).isActive = true
        
        strengthDescriptionLabel.text = "Empty"
        strengthDescriptionLabel.font = labelFont
        
    }
    
    @objc
    func showHideTapped(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "eyes-closed") {
            sender.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            sender.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
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
        if oldText.count < 5 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        } else if oldText.count < 10 {
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
            strongView.backgroundColor = unusedColor
        } else if oldText.count < 15 {
            strongView.backgroundColor = strongColor
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
        }
        return true
    }
}
