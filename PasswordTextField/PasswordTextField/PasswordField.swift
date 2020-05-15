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
    private (set) var passwordStrength: String = "Too weak"
    
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
    
    private var mediumColorViewHeightAnchor: NSLayoutConstraint!
    private var strongColorViewHeightAnchor: NSLayoutConstraint!
    
    func setup() {
        // Lay out your subviews here
        self.backgroundColor = bgColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.text = "ENTER PASSWORD"
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        //        self.bringSubviewToFront(textField)
        textField.keyboardType = .default
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: textField.frame.size.width - 36, y: 10, width: 26.0, height: 26.0)
        showHideButton.addTarget(self, action: #selector(showHideBtnDidTapped), for: .touchUpInside)
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 6).isActive = true
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.backgroundColor = weakColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 6).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumColorViewHeightAnchor = mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        mediumColorViewHeightAnchor.isActive = true
        mediumView.backgroundColor = unusedColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 6).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongColorViewHeightAnchor = strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        strongColorViewHeightAnchor.isActive = true
        strongView.backgroundColor = unusedColor
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = "Too weak"
        
        textField.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func showHideBtnDidTapped(_ sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        self.checkTextFieldStrength(newPasswrd: newText)
        return true
    }
    
    private func checkTextFieldStrength(newPasswrd: String) {
        self.mediumView.backgroundColor = unusedColor
        self.strongView.backgroundColor = unusedColor
        self.passwordStrength = "Too weak"
        strengthDescriptionLabel.text = "Too weak"
        
        if newPasswrd.count > 9 && newPasswrd.count < 20 {
            
            UIView.animate(withDuration: 2.0, delay: 0, options: [], animations: {
                self.mediumColorViewHeightAnchor.constant = self.colorViewSize.height + 2
            }, completion: { (finished: Bool) in
                self.mediumColorViewHeightAnchor.constant = self.colorViewSize.height
            })
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could be stronger"
            self.passwordStrength = "Could be stronger"
        }
        if newPasswrd.count > 19 {
            UIView.animate(withDuration: 4.0, delay: 0, options: .curveEaseInOut, animations: {
                self.mediumColorViewHeightAnchor.constant = self.colorViewSize.height + 2
            }, completion: { (finished: Bool) in
                self.mediumColorViewHeightAnchor.constant = self.colorViewSize.height
            })
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
            self.passwordStrength = "Strong password"
        }
    }
}
