//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

// TODO: passwordStrength enum

@IBDesignable
class PasswordField: UIControl {
    
    // MARK: - Properties
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    // SIZES
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    // COLORS
        // label
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        // text field
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
        // strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    // IMAGES
    private let eyesClosedImage = #imageLiteral(resourceName: "eyes-closed")
    private let eyesOpenImage = #imageLiteral(resourceName: "eyes-open")
    
    // SUBVIEWS
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    // MARK: - Subview Setup
    
    func setup() {
        // Lay out your subviews here
        
        // Background
        backgroundColor = bgColor
        
        // "ENTER PASSWORD" TITLE LABEL
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
            // appearance
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
            // size & position
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
        ])
        
        // "PASSWORD" TEXT FIELD
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
            // appearance
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 1.0
        textField.isSecureTextEntry = true
        
            // size & position
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // "EYEBALL" "HIDE/SHOW TEXT" BUTTON
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
            // appearance
        showHideButton.setImage(eyesClosedImage, for: .normal)
        
            // size & position
        NSLayoutConstraint.activate([
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin),
            showHideButton.widthAnchor.constraint(equalToConstant: eyesClosedImage.size.width),
            showHideButton.heightAnchor.constraint(equalToConstant: eyesClosedImage.size.height)
        ])
        
        // WEAK VIEW
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
            // appearance
        weakView.backgroundColor = unusedColor
        
            // size & position
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 5),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        // MEDIUM VIEW
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
            // appearance
        mediumView.backgroundColor = unusedColor
        
            // size & position
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 5),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        // STRONG VIEW
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
            // appearance
        strongView.backgroundColor = unusedColor

            // size & position
        NSLayoutConstraint.activate([
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 5),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        // STRENGTH DESCRIPTION LABEL
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
            // appearance
        strengthDescriptionLabel.text = "Nothing Typed"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont

            // size & position
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin)
        ])
    }
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

    // MARK: - Actions

    // "PASSWORD" TEXT FIELD WAS EDITED
    // TODO: call password strength method

    // "RETURN" ON KEYBOARD WAS PRESSED
    // TODO: hide keyboard

    // "EYEBALL" "SHOW -OR- HIDE" BUTTON WAS PRESSED
    // TODO: call show -or- hide method

    // MARK: - Methods

    // SHOW PASSWORD STRENGTH
    // TODO: update the subviews based on password length

    // SHOW -OR- HIDE PASSWORD
    // TODO: hide or show text based on button pressed

    // MARK: - Extensions

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}

// MARK: - Stretch Goals
// TODO: pulse animations for increasing strength
// TODO: debounce for only sending final password?
// TODO: check password with dictionary
