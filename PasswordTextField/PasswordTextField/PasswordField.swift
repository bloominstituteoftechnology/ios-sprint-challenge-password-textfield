//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    enum StrengthValue: String {
        case weak = "Too weak"
        case medium = "Could be stronger"
        case strong = "Strong password"
    }
    
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
        
        self.backgroundColor = bgColor
        
        // title label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin).isActive = true
        // Do we need a height constraint or does it go off of font size?
        //        titleLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        titleLabel.font = labelFont
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        
        // text field
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.textAlignment = .natural
        textField.isSecureTextEntry = true
        textField.becomeFirstResponder()
        textField.addTarget(self, action: #selector(passwordFieldEnter), for: .valueChanged)
        
        //show/hide button
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10.0).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -textFieldContainerHeight * 0.33).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -50.0).isActive = true
        // Do I set the image here or in a func for eyes-closed == true, eyes-opened == false or in addTarget func?
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(updateShowHideButton), for: .touchUpInside)
        
        // weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12.0).isActive = true
        weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        
        weakView.backgroundColor = unusedColor
        
        
        // medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12.0).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 6).isActive = true
        
        mediumView.backgroundColor = unusedColor
        
        
        // strong view
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12.0).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 6).isActive = true
        
        strongView.backgroundColor = unusedColor
        
        //strength label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 6.0).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 8).isActive = true
        strengthDescriptionLabel.text = ""
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
        strengthDescriptionLabel.textAlignment = .left
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    func textFieldValueChanged(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        addTarget(self, action: #selector(ViewController.passwordEntered(_:)), for: .valueChanged)
        print(password)
        print(strengthDescriptionLabel.text ?? "")

        return true
    }
    
    @objc private func passwordFieldEnter() {
        textField.resignFirstResponder()
        print(password)
        print(self.strengthDescriptionLabel)
    }
    ////// THIS NEEDS ATTENTION
    @objc private func updateShowHideButton(sender: UIButton) {
        
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        textField.isSecureTextEntry = false
    }
    
    
    private func determineStrength(password: String) {
        
        let length = password.count
        
        switch length {
        case 0:
            self.weakView.backgroundColor = unusedColor
            self.mediumView.backgroundColor = unusedColor
            self.strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = StrengthValue.weak.rawValue
            self.weakView.transform = CGAffineTransform(scaleX: .zero, y: .zero)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                self.weakView.transform = .identity
            }, completion: nil)
            
        case 1...9:
            self.weakView.backgroundColor = weakColor
            self.mediumView.backgroundColor = unusedColor
            self.strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = StrengthValue.weak.rawValue
            self.weakView.transform = .identity
            
        case 10:
            self.mediumView.transform = CGAffineTransform(scaleX: .zero, y: .zero)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                self.mediumView.transform = .identity
            }, completion: nil)
            strengthDescriptionLabel.text = StrengthValue.medium.rawValue
            self.weakView.backgroundColor = weakColor
            self.mediumView.backgroundColor = mediumColor
            self.strongView.backgroundColor = unusedColor
            
            
        case 11...19:
            strengthDescriptionLabel.text = StrengthValue.medium.rawValue
            self.weakView.backgroundColor = weakColor
            self.mediumView.backgroundColor = mediumColor
            self.strongView.backgroundColor = unusedColor
            self.mediumView.transform = .identity
            
        case 20:
            self.strongView.transform = CGAffineTransform(scaleX: .zero, y: .zero)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                self.strongView.transform = .identity
            }, completion: nil)
        default:
            strengthDescriptionLabel.text = StrengthValue.strong.rawValue
            self.weakView.backgroundColor = weakColor
            self.mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            self.strongView.transform = .identity
        }
    }
    
    // MARK: - Touch Tracking
    
    // Start tracking touch in control
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateShowHideButton(sender: showHideButton)
        return true
    }
    
    // End tracking touch in control
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else {
            NSLog("Unable to track touch")
            return
        }
        
        let touchPoint = touch.location(in: self)
        if showHideButton.bounds.contains(touchPoint) {
            updateShowHideButton(sender: showHideButton)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: .touchUpOutside)
        }
    }
    
    // Cancel tracking
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength(password: newText)
        return true
    }
}
