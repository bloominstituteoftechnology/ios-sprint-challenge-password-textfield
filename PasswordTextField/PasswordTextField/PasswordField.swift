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
    
    private var showingPassword = false
    
    func setup() {
        self.backgroundColor = bgColor
        
        // Lay out your subviews here
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.text = "ENTER PASSWORD"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin).isActive = true
        
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: textFieldMargin * -1).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.delegate = self
        textField.isSecureTextEntry = true
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        weakView.backgroundColor = weakColor
        weakView.frame.size = colorViewSize
        mediumView.backgroundColor = mediumColor
        mediumView.frame.size = colorViewSize
        strongView.backgroundColor = strongColor
        strongView.frame.size = colorViewSize
        
        let stackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 7.5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin * -1).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: standardMargin).isActive = true
        
        
    }
    
    @objc func showHidePassword() {
        if showingPassword {
            showingPassword = false
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        } else {
            showingPassword = true
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        }
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
        let strength = determineStrength(of: newText)
        switch strength {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too Weak"
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could be stronger"
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        }
        return true
    }
}
extension PasswordField {
    enum Strength {
        case weak
        case medium
        case strong
    }
    func determineStrength(of password: String) ->Strength {
        switch password.count {
        case 0...9:
            return .weak
        case 10...19:
            return .medium
        case 20...:
            return .strong
        default:
            break
        }
        return .weak
    }
}
