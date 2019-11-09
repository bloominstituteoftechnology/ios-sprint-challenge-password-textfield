//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable
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
    private var textFieldContainerView: UIView = UIView()
    private var textFieldIconLabel: UILabel = UILabel()
    

    
    func setup() {
        // Lay out your subviews here
        
        titleLabel.text = "Password"
        titleLabel.textColor = labelTextColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        addSubview(textFieldContainerView)
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        textFieldContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldContainerView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        textFieldContainerView.layer.backgroundColor = #colorLiteral(red: 0.9213470245, green: 0.9213470245, blue: 0.9213470245, alpha: 1)
        textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainerView.layer.borderWidth = 0.5
        textFieldContainerView.layer.cornerRadius = 5.0
        
        
        textFieldContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -8).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 46).isActive = true
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        
//        textFieldIconLabel.text = "👀"
//        textFieldIconLabel.textAlignment = .right
//        addSubview(textFieldIconLabel)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textFieldIconLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
//        textFieldIconLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
//        textFieldIconLabel.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true

        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
