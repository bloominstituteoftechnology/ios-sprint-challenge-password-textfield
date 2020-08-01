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
    
//    private var textFieldContainer: UIView = UIView()
    
    private var textIsHidden: Bool = false
    
    func setup() {
        
        isUserInteractionEnabled = true
        
        backgroundColor = .darkGray
        
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.text = "Enter Password"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)])
        
//        textFieldContainer.layer.cornerRadius = 8
//        textFieldContainer.layer.borderColor = textFieldBorderColor.cgColor
//        textFieldContainer.layer.borderWidth = 3
//        addSubview(textFieldContainer)
//        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
//            textFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
//            textFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
//            textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)])
        
        showHideButton.contentMode = .scaleAspectFit
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHide), for: .touchUpInside)
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "password"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.rightView = showHideButton
        textField.rightViewMode = .always

        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 8
        textField.delegate = self
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)])
        
//        NSLayoutConstraint.activate([
//            showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
//            showHideButton.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin),
//            showHideButton.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -textFieldMargin)])
        
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = 2
        weakView.frame = CGRect(x: standardMargin, y: self.bounds.size.height - standardMargin, width: 50, height: 5)
        addSubview(weakView)
        
        mediumView.backgroundColor = mediumColor
        mediumView.layer.cornerRadius = 2
        mediumView.frame = CGRect(x: standardMargin + 52, y: self.bounds.size.height - standardMargin, width: 50, height: 5)
        addSubview(mediumView)
        
        strongView.backgroundColor = strongColor
        strongView.layer.cornerRadius = 2
        strongView.frame = CGRect(x: standardMargin + (2 * 52), y: self.bounds.size.height - standardMargin, width: 50, height: 5)
        addSubview(strongView)
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = "test"
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin)])

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc private func showHide() {
        switch textIsHidden {
        case true:
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = true
        case false:
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = false
        }
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
