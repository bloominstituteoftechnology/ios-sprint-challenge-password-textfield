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
    private (set) var password: String = Strength.weak.rawValue
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.delegate = self
        setup()
        
    }
    
    func setup() {
        // Lay out your subviews here
        
        backgroundColor = bgColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        
        textField.placeholder = "Enter your password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.isSecureTextEntry = false
        addSubview(textField)
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        addSubview(weakView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = mediumColor
        addSubview(mediumView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = strongColor
        addSubview(strongView)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = Strength.weak.rawValue
        addSubview(strengthDescriptionLabel)
        
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        addSubview(showHideButton)
        
        
        
        NSLayoutConstraint.activate ([
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            weakView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            
            
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 3),
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            mediumView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            
    strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 3),
            strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            
            strongView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            strongView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: standardMargin),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -standardMargin),
            showHideButton.widthAnchor.constraint(equalToConstant: 20),
            
            
            
        ])
    }
    
    
    @objc func showHideButtonTapped() {
        
        textField.isSecureTextEntry = !(textField.isSecureTextEntry)
        print("The #selector is working")
        if textField.isSecureTextEntry == true{
            
            self.showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    
    func passwordStrengthDetermined(password: String) {
        
        
        
        /// I have started all over on this function. I had a mess that wouldn't work so I am redoing it.
        
        
    }
    
    
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        passwordStrengthDetermined(password: newText)
        // TODO: send new text to the determine strength method
        return true
    }
}
enum Strength: String {
    case stongest = "Impenetrable"
    case suitable =  "Almost there"
    case weak = "This aint gonna work"
    
}
