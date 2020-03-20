//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
class PasswordField: UIControl, UITextFieldDelegate {
    
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
    
    func setup() {
        self.backgroundColor = UIColor(displayP3Red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = labelTextColor
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        
        addSubview(textField)
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2
        textField.isSecureTextEntry = true
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
        addSubview(showHideButton)
        showHideButton.isUserInteractionEnabled = true
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(#imageLiteral(resourceName: "eyes-closed"), for: .normal)
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin).isActive = true
        showHideButton.addTarget(self, action: #selector(showOrHide), for: .touchUpInside)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = unusedColor
        weakView.frame = CGRect(x: standardMargin, y: 85, width: colorViewSize.width, height: colorViewSize.height)
        
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        mediumView.frame = CGRect(x: colorViewSize.width + 2 * standardMargin, y: 85, width: colorViewSize.width, height: colorViewSize.height)
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        strongView.frame = CGRect(x: colorViewSize.width * 2 + 3 * standardMargin, y: 85, width: colorViewSize.width, height: colorViewSize.height)
        
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.text = " "
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 12)
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 220).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldMargin * 1.5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    @objc func showOrHide() {
        textField.isSecureTextEntry.toggle()
        
        if textField.isSecureTextEntry == true {
            showHideButton.setImage(#imageLiteral(resourceName: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(#imageLiteral(resourceName: "eyes-open"), for: .normal)
        }
    }
    func empty() {
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        strengthDescriptionLabel.text = " "
    }
    func weak() {
         
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        strengthDescriptionLabel.text = "Security level: Weak"
    }
    func med() {
         
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = mediumColor
        strongView.backgroundColor = unusedColor
        strengthDescriptionLabel.text = "Security level: Medium"
    }
    func strong() {
         
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = mediumColor
        strongView.backgroundColor = strongColor
        strengthDescriptionLabel.text = "Security level: Strong"
    }
    func passwordSecureLevel(password: String) {
        let passwordCount = password.count
        switch passwordCount {
        case 0:
            empty()
        case 1...9:
            if weakView.backgroundColor != weakColor {
                weakView.transform = CGAffineTransform(scaleX: 1, y: 3)
                UIView.animate(withDuration: 0.5, animations: {
                    self.weakView.transform = .identity
                })
            }
            weak()
        case 10...19:
            if mediumView.backgroundColor != mediumColor {
                mediumView.transform = CGAffineTransform(scaleX: 1, y: 3)
                UIView.animate(withDuration: 0.5, animations: {
                    self.mediumView.transform = .identity
                })
            }
            med()
        default:
            if strongView.backgroundColor != strongColor {
                strongView.transform = CGAffineTransform(scaleX: 1, y: 3)
                UIView.animate(withDuration: 0.5, animations: {
                    self.strongView.transform = .identity
                })
            }
            strong()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordSecureLevel(password: newText)
        return true
    }
}
