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
        
        addSubview(titleLabel)
        addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(textField)
        addSubview(strengthDescriptionLabel)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        

       
        
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        
        strengthDescriptionLabel.text = "Too Weak"
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        showHideButton.setImage(, for: .normal)
        
        
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor).isActive = true
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
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
        strengthDescriptionLabel.text = newText
        return true
    }
}
