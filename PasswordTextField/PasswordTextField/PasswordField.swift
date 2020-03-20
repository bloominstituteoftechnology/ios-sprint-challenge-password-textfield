//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // MARK: - Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // MARK: - States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    // MARK: - UI Element Properties
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    
    // MARK: - Methods
    
    func setup() {
        // Lay out your subviews here
        
        // MARK: - titleLabel
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
        ])
        
        // MARK: - Textfield
        
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 5
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = .never
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.default
        textField.contentVerticalAlignment = .center
//        textField.textAlignment = .center
        textField.textColor = .black
        textField.placeholder = "Is this working"
        textField.textContentType = .password
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        textField.delegate = self
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        
        // MARK: - Hide button
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.isEnabled = true
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .disabled)
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        
        // MARK: - Strength indicators stack view
        var indicatorsArray: [UIView] = [weakView, mediumView, strongView]
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)
//        weakView.translatesAutoresizingMaskIntoConstraints = false
//        mediumView.translatesAutoresizingMaskIntoConstraints = false
//        strongView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for indicator in indicatorsArray {

            indicator.backgroundColor = unusedColor
            indicator.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(indicator)
            indicator.widthAnchor.constraint(equalToConstant: 70).isActive = true
            indicator.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
        
        strengthDescriptionLabel.text = " Hello world "
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(strengthDescriptionLabel)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin),
            stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin)
        ])
    }
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}


// MARK: - Extension

extension PasswordField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
