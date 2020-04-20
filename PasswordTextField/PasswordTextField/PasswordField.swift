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
    @objc private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var iconSelected: Bool = false
    
    func setup() {
        // Title Label
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)])
        
        // TextField
        
        textField.placeholder = "Enter text here"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        textField.layer.borderColor = textFieldBorderColor.cgColor
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: textFieldMargin),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: textFieldMargin)])
        
        // Show/ Hide Button
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.addTarget(self, action: #selector(showHideAction), for: .touchUpInside)
        showHideButton.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        
        // stackView
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldMargin),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: textFieldMargin),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: textFieldMargin),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: textFieldMargin)])
        
        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)
        stackView.addArrangedSubview(strengthDescriptionLabel)
        
        // Weak, Medium, Strong
        weakView.backgroundColor = weakColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weakView.widthAnchor.constraint(equalToConstant: 60),
            weakView.heightAnchor.constraint(equalToConstant: 5)])
        
        mediumView.backgroundColor = mediumColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mediumView.widthAnchor.constraint(equalToConstant: 60),
            mediumView.heightAnchor.constraint(equalToConstant: 5)])
        
        strongView.backgroundColor = strongColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strongView.widthAnchor.constraint(equalToConstant: 60),
            strongView.heightAnchor.constraint(equalToConstant: 5)])
        
        strengthDescriptionLabel.text = "too weak"
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    @objc func showHideAction(sender: UIButton) {
        iconSelected.toggle()
        if showHideButton.isEnabled{
            if iconSelected == true {
                showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
                textField.isSecureTextEntry = true
            } else {
                
                showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
                textField.isSecureTextEntry = false
            }
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
