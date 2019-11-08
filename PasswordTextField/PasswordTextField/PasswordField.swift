//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum Strength {
    case weak
    case medium
    case strong
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private var strength = Strength.weak {
        didSet {
            if strength == .weak {
                strengthDescriptionLabel.text = "Too weak"
            } else if strength == .medium {
                strengthDescriptionLabel.text = "Could be stronger"
            } else {
                strengthDescriptionLabel.text = "Strong password"
            }
            if password.count == 10 {
                mediumView.performFlare()
            } else if password.count == 20 {
                strongView.performFlare()
            }
            
        }
    
    }
    
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
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.backgroundColor = .clear
    
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: textFieldMargin).isActive = true
        textField.layer.masksToBounds = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(editing), for: .editingChanged)
        textField.addTarget(self, action: #selector(doneEditing), for: .editingDidEnd)
        
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -(standardMargin + 20)).isActive =  true
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showHideButton.addTarget(self, action: #selector(self.toggleButton), for: .touchDown)
        showHideButton.isUserInteractionEnabled = true
//
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1.5 * standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.layer.cornerRadius = 3
        weakView.layer.masksToBounds = true
        weakView.backgroundColor = weakColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin/2).isActive = true
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1.5 * standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.layer.cornerRadius = 3
        mediumView.layer.masksToBounds = true
        mediumView.backgroundColor = unusedColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin/2).isActive = true
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1.5 * standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.layer.cornerRadius = 3
        strongView.layer.masksToBounds = true
        strongView.backgroundColor = unusedColor
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor).isActive = true
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.backgroundColor = .clear
    }
    
    @objc func editing() {
        if  password.count < 10 {
            strength = .weak
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        } else if password.count > 9 && password.count < 20 {
            strength = .medium
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        } else {
            strength = .strong
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
    
    @objc func doneEditing() {
        resignFirstResponder()
        print("\(self.password) is of strength: \(self.strength)")
    }
    
    @objc func toggleButton() {
        showHideButton.isSelected.toggle()
        if showHideButton.isSelected {
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
        self.isUserInteractionEnabled = true
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendActions(for: .editingDidEnd)
        return true
    }
}


extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.2, y: 1.2) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
