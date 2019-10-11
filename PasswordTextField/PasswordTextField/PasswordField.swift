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
    private var passwordContainer: UIView = UIView()
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textFieldMargin).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        addSubview(passwordContainer)
        passwordContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordContainer.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        passwordContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordContainer.heightAnchor.constraint(equalToConstant: 54).isActive = true
        passwordContainer.layer.borderColor = textFieldBorderColor.cgColor
        passwordContainer.layer.borderWidth = 2
        passwordContainer.layer.cornerRadius = 8
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 4).isActive = true
        textField.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 2).isActive = true
        textField.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -90).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: -2).isActive = true
        textField.placeholder = "Enter password here"
        textField.textColor = UIColor.black
        textField.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        textField.textAlignment = .left

        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: passwordContainer.topAnchor, constant: 18).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor, constant: -8).isActive = true
        changeImage()
        showHideButton.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
        

        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor, constant: 8).isActive = true
        weakView.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 8).isActive = true
        weakView.trailingAnchor.constraint(equalTo: weakView.leadingAnchor, constant: 50).isActive = true
        weakView.bottomAnchor.constraint(equalTo: weakView.topAnchor, constant: 3).isActive = true
        
        if password.count > 0, password.count <= 4 {
            weakView.backgroundColor = weakColor;
            strengthDescriptionLabel.text = "Weak Password"
        } else {
            weakView.backgroundColor = unusedColor
        }
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 3).isActive = true
        mediumView.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 8).isActive = true
        mediumView.trailingAnchor.constraint(equalTo: mediumView.leadingAnchor, constant: 50).isActive = true
        mediumView.bottomAnchor.constraint(equalTo: mediumView.topAnchor, constant: 3).isActive = true
        
        if password.count > 4, password.count <= 8 {
            mediumView.backgroundColor = mediumColor;
            strengthDescriptionLabel.text = "Weak Ok"
        } else {
            mediumView.backgroundColor = unusedColor
        }
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 8).isActive = true
        strongView.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 8).isActive = true
        strongView.trailingAnchor.constraint(equalTo: strongView.leadingAnchor, constant: 50).isActive = true
        strongView.bottomAnchor.constraint(equalTo: strongView.topAnchor, constant: 3).isActive = true
        
        if password.count > 0, password.count <= 4 {
            strongView.backgroundColor = strongColor;
            strengthDescriptionLabel.text = "Strong Password"
        } else {
            strongView.backgroundColor = unusedColor
        }
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 8).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 4).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor).isActive = true
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .light)
        
    }
    
    @objc func changeImage() {
        
        if showHideButton.isSelected == true {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal);
            for _ in password {
                _ = "*"
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: showHideButton)
        
        if showHideButton.bounds.contains(touchPoint) {
            sendActions(for: [.valueChanged, .touchUpInside])
        } else {
            sendActions(for: [.touchUpInside])
            
            return false
        }
        
        return false
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: showHideButton)
        
        if showHideButton.bounds.contains(touchPoint) {
            sendActions(for: [.valueChanged, .touchUpInside])
            
        } else {
            sendActions(for: [.touchUpInside])
        }
        
        return true
        
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        guard let touchPoint = touch?.location(in: showHideButton) else { return }
        
        if showHideButton.bounds.contains(touchPoint) {
            sendActions(for: [.valueChanged, .touchUpInside])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
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
