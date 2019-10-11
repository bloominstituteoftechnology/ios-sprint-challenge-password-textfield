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
        
        // DIRECTION TITLE
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        // TEXT FIELD
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.contentVerticalAlignment = .center
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        
        // SHOW/HIDE BUTTON
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage (named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin)])
        
        // WEAK VIEW
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        // MEDIUM VIEW
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = mediumColor
        
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 3),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        // STRONG VIEW
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = strongColor
        
        NSLayoutConstraint.activate([
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 3),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        // STRENGTH DESCRIPTION LABEL
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Strong Password"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 3)
        ])
        
    }
    
    @objc func showHideButtonTapped() {
        var eyesClosed = true
        eyesClosed.toggle()
        if eyesClosed == true {
            showHideButton.setImage(UIImage (named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        } else {
            showHideButton.setImage(UIImage (named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
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
        // TODO: send new text to the determine strength method
        return true
    }
}
