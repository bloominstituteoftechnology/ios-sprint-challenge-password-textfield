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
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc @IBAction func showHide() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        
        switch textField.isSecureTextEntry {
        case true:
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        default:
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    func setup() {
        self.backgroundColor = bgColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: standardMargin),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: standardMargin),
            NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -standardMargin)
        ])
        titleLabel.text = "Enter your password:"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: textFieldMargin),
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: standardMargin),
            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -standardMargin)
        ])
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 3
        textField.delegate = self
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: showHideButton, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: showHideButton, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: showHideButton, attribute: .width, relatedBy: .equal, toItem: textField, attribute: .width, multiplier: 0.15, constant: 0),
            NSLayoutConstraint(item: showHideButton, attribute: .height, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 1, constant: 0)
        ])
        showHideButton.addTarget(self, action: #selector(showHide), for: .touchUpInside)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = unusedColor
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: weakView, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: textFieldMargin),
            NSLayoutConstraint(item: weakView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: standardMargin),
            NSLayoutConstraint(item: weakView, attribute: .bottom, relatedBy: .equal, toItem: weakView, attribute: .top, multiplier: 1, constant: colorViewSize.height),
            NSLayoutConstraint(item: weakView, attribute: .trailing, relatedBy: .equal, toItem: weakView, attribute: .leading, multiplier: 1, constant: colorViewSize.width)
        ])
        weakView.layer.cornerRadius = 3
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: mediumView, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: textFieldMargin),
            NSLayoutConstraint(item: mediumView, attribute: .leading, relatedBy: .equal, toItem: weakView, attribute: .trailing, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: mediumView, attribute: .bottom, relatedBy: .equal, toItem: mediumView, attribute: .top, multiplier: 1, constant: colorViewSize.height),
            NSLayoutConstraint(item: mediumView, attribute: .trailing, relatedBy: .equal, toItem: mediumView, attribute: .leading, multiplier: 1, constant: colorViewSize.width)
        ])
        mediumView.layer.cornerRadius = 3
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: strongView, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: textFieldMargin),
            NSLayoutConstraint(item: strongView, attribute: .leading, relatedBy: .equal, toItem: mediumView, attribute: .trailing, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: strongView, attribute: .bottom, relatedBy: .equal, toItem: strongView, attribute: .top, multiplier: 1, constant: colorViewSize.height),
            NSLayoutConstraint(item: strongView, attribute: .trailing, relatedBy: .equal, toItem: strongView, attribute: .leading, multiplier: 1, constant: colorViewSize.width)
        ])
        strongView.layer.cornerRadius = 3
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: textFieldMargin),
            NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: strongView, attribute: .trailing, multiplier: 1, constant: textFieldMargin),
            NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        strengthDescriptionLabel.text = "Preview text"
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
