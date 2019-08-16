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
    

    
    func setup() {
        
        self.backgroundColor = bgColor
        
        //Title Label Set Up
        titleLabel.text = "I AM THE LABEL"
        titleLabel.font = labelFont
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        //Title Label Constraints
        let titleLabelLeading = titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin)
        let titleLabelTop = titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: standardMargin)
        
        
        
        //TextField Set Up
        textField.placeholder = "Enter Password"
        textField.font = labelFont
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        //TextField Constraints
        let textFieldLeadingAnchor = textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin)
        let textFieldTopAnchor = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin)
        let textFieldTrailingAnchor = textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)

        //ShowHide Button Set up
        showHideButton.backgroundColor = .clear
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 340.0, y: 38.0, width: 20.0, height: 20.0)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        let showHideButtonLeading = showHideButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 340)
        let showHideButtonTop = showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 4)
        let showHideButtonTrailing = showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 4)
        addSubview(showHideButton)
        
        //weakView Set up
        weakView.backgroundColor = .gray
        weakView.frame = CGRect(x: 8, y: 70.0, width: 60.0, height: 5)
        addSubview(weakView)
        
        let weakViewLeading = weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin)
        let weakViewTop = weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin)
        
        //MediumView SetUp
        
        mediumView.backgroundColor = .gray
        mediumView.frame = CGRect(x: weakView.bounds.width + 16, y: 70.0, width: 60.0, height: 5)
        addSubview(mediumView)
        
        //StringView SetUp
        
        strongView.backgroundColor = .gray
        strongView.frame = CGRect(x: weakView.bounds.width + mediumView.bounds.width + 24, y: 70.0, width: 60.0, height: 5)
        addSubview(strongView)
        
        let strongViewLeading = strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 6)
        // TODO: - Constraints
        
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.frame = CGRect(x: 220.0, y: 70.0, width: 200.0, height: 14.0)
        addSubview(strengthDescriptionLabel)
        
      
        
        
        NSLayoutConstraint.activate([titleLabelLeading, titleLabelTop, textFieldLeadingAnchor, textFieldTopAnchor, textFieldTrailingAnchor, showHideButtonLeading, showHideButtonTop, showHideButtonTrailing, weakViewLeading, weakViewTop, strongViewLeading])
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
        // TODO: send new text to the determine strength method
        updateStatus(with: wordCount)
        
        return true
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


