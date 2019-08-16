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
    private (set) var passwordRating: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let eyeSize: CGSize = CGSize(width: 20.0, height: 20.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    private var buttonWasTapped: Bool = false
    
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

    
    func setup() {
        
        self.backgroundColor = bgColor
        
        // Title Label Set Up
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Title Label Constraints
        let titleLabelLeading = titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin)
        let titleLabelTop = titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: standardMargin)
        
        // TextField Set Up
        textField.placeholder = "Enter Password"
        textField.font = labelFont
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        // TextField Constraints
        let textFieldLeadingAnchor = textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin)
        let textFieldTopAnchor = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin)
        let textFieldTrailingAnchor = textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)

        // ShowHide Button Set up
        showHideButton.backgroundColor = .clear
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        
        // ShowHide Button Constraints
        let showHideButtonTop = showHideButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40)
        let showHideButtonTrailing = showHideButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        let showHideButtonWidth = showHideButton.widthAnchor.constraint(equalToConstant: eyeSize.width)
        let showHideButtonHeight = showHideButton.heightAnchor.constraint(equalToConstant: eyeSize.height)
        
        // weakView Set up
        weakView.backgroundColor = .gray
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        
        // weakview constraints
        let weakViewWidth = weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        let weakViewHeight = weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        let weakViewLeading = weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin)
        let weakViewTop = weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin)
        
        // MediumView SetUp
        
        mediumView.backgroundColor = .gray
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        
        // mediumView Constraints
        let medViewWidth = mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        let medViewHeight = mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        let medViewLeading = mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin)
        let medViewTop = mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin)

        // strongView Setup
        strongView.backgroundColor = .gray
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        
        // strongView Constraints
        let strViewWidth = strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        let strViewHeight = strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        let strViewLeading = strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin)
        let strViewTop = strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin)

        // strengthDiscriptionLabel Setup
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
        // strengthDiscriptionLabel Constraints
        let descriptionLeading = strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin)
        let descriptionTop = strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2)
        
        
        NSLayoutConstraint.activate([titleLabelLeading, titleLabelTop, textFieldLeadingAnchor, textFieldTopAnchor, textFieldTrailingAnchor, showHideButtonTop, showHideButtonTrailing,showHideButtonWidth, showHideButtonHeight, weakViewWidth, weakViewHeight, weakViewLeading, weakViewTop, medViewWidth, medViewHeight, medViewLeading, medViewTop, strViewWidth, strViewHeight, strViewLeading, strViewTop, descriptionLeading, descriptionTop])
    }
    
    @objc func showHideButtonTapped(sender: UIButton!) {
        buttonWasTapped.toggle()
        if buttonWasTapped == true {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
    private func updateStatus(with wordCount: Int) {
        
         if wordCount >= 1 && wordCount < 10 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = .gray
            strongView.backgroundColor = .gray
            strengthDescriptionLabel.text = "Too weak"
            weakView.performFlare()
        } else if wordCount >= 10 && wordCount < 20 {
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = .gray
            mediumView.performFlare()
            strengthDescriptionLabel.text = "Could be stronger"
        } else if wordCount >= 20 {
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong Password"
            strongView.performFlare()
        } else {
            weakView.backgroundColor = .gray
            mediumView.backgroundColor = .gray
            strongView.backgroundColor = .gray
        }
        
    }
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        let wordCount = newText.count
        updateStatus(with: wordCount)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        if let text = textField.text,
            let rating = strengthDescriptionLabel.text,
            !text.isEmpty {
            password = text
            passwordRating = rating
            sendActions(for: [.valueChanged])
        }
        return false
    }
}

extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}


