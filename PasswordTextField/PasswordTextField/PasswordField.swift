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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func setup() {
        backgroundColor = .blue
        
        let container = UIView()
        container.backgroundColor = bgColor
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            container.heightAnchor.constraint(equalToConstant: 200), // remove at end
        ])
        
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.backgroundColor = .clear
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -standardMargin),
            //titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -standardMargin),
        ])
        
        let textFieldContainer = UIView()
        textFieldContainer.layer.borderWidth = 2
        textFieldContainer.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainer.layer.cornerRadius = 7
        container.addSubview(textFieldContainer)
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textFieldContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: standardMargin),
            textFieldContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -standardMargin),
            textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
        ])
        
        textField.placeholder = "password"
        textFieldContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: textFieldMargin),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin),
        ])
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        textFieldContainer.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            showHideButton.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
        ])
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
