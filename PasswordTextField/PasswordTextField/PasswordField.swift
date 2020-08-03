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
        // Adding my background color
        backgroundColor.self = bgColor


        // Added my title Label "ENTER PASSWORD"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor

        // Creating my text field container
        let textFieldContainerView = UIView()
        addSubview(textFieldContainerView)
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            textFieldContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textFieldContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textFieldContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
        ])
        textFieldContainerView.layer.borderWidth = 2.3
        textFieldContainerView.layer.cornerRadius = 8
        textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor

        // Creating text field in the container
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor,constant: 15.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -textFieldMargin)
        ])
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.placeholder = "Password Exp: (SRn-*sl-!er-k$!)"



        // Creating button to show hidden text
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 4.0).isActive = true
        showHideButton.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: textFieldMargin).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        textFieldContainerView.bottomAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: textFieldMargin).isActive = true
        showHideButton.isUserInteractionEnabled = true
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.isHidden = false

        // Creating weak Level views
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: standardMargin * 2),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        ])
        weakView.layer.backgroundColor = unusedColor.cgColor

        // Creating Medium Level view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: standardMargin * 2),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: textFieldMargin),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        ])
        mediumView.layer.backgroundColor = unusedColor.cgColor



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
        //

        return true
    }
}
