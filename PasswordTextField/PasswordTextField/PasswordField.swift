//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
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
        
        backgroundColor = bgColor
        
        // Add subviews
        addSubview(titleLabel)
        addSubview(textField)
        textField.addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        // Turn off Autoresizing Mask translation
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrain
        let widthBy6 = frame.width / 6
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.7),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
            
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor),
            weakView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            weakView.widthAnchor.constraint(equalToConstant: widthBy6),
            weakView.heightAnchor.constraint(equalToConstant: 4.0),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin / 2),
            mediumView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            mediumView.widthAnchor.constraint(equalToConstant: widthBy6),
            mediumView.heightAnchor.constraint(equalTo: weakView.heightAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin / 2),
            strongView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            strongView.widthAnchor.constraint(equalToConstant: widthBy6),
            strongView.heightAnchor.constraint(equalTo: weakView.heightAnchor),
            
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            
        ])
        
        // Initialize labels and text field
        titleLabel.text = "ENTER PASSWORD"
        textField.placeholder = "Choose a strong password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
//        textField.delegate = self
        textField.isEnabled = true
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideTapped), for: .touchUpInside)
        strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
        
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
                
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.delegate = self
        setup()
    }
    
    @objc private func showHideTapped() {
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
    }
    
    func strengthOf(_ password: String) -> PasswordStrength {
        return .medium
    }

}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength = strengthOf(newText)
        return true
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("begin editing")
//        return true
//    }
}
