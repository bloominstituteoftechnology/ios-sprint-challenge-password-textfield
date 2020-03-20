//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthValue: String {
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}
@IBDesignable
class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
//    private let stackView = UIStackView()
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
//        self.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
//        self.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
//        self.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        self.backgroundColor = bgColor
        // title
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        // text field
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 8.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.becomeFirstResponder()
        textField.textAlignment = .left
        textField.isSecureTextEntry.toggle()
        textField.backgroundColor = bgColor
        textField.addTarget(self, action: #selector(determineStrength), for: .valueChanged)
        
        // show/hide button
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10.0).isActive = true
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: textFieldContainerHeight / 4).isActive = true
        showHideButton.adjustsImageWhenDisabled = true
        let noShowImage = UIImage(named: "eyes-closed")
        showHideButton.setImage(noShowImage, for: .normal)
        let showImage = UIImage(named: "eyes-open")
        showHideButton.setImage(showImage, for: .disabled)
        showHideButton.addTarget(self, action: #selector(updateShowHideButton), for: .touchUpInside)
        
        // weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        weakView.backgroundColor = unusedColor
        
        
        // medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 6).isActive = true
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        mediumView.backgroundColor = unusedColor
        
        
        // strong view
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 6).isActive = true
        strongView.backgroundColor = unusedColor
        
        //strength label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 8).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        strengthDescriptionLabel.text = ""
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .semibold)
        strengthDescriptionLabel.textAlignment = .left
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    @objc private func updateShowHideButton(at touch: UITouch) {
        
        let noShowImage = UIImage(named: "eyes-closed")
        let showImage = UIImage(named: "eyes-open")
        let touchPoint = touch.location(in: self)
        
        if showHideButton.frame.contains(touchPoint){
            textField.isSecureTextEntry = false
            showHideButton.setImage(showImage, for: .normal)
            
        } else {
            textField.isSecureTextEntry = true
            
            showHideButton.setImage(noShowImage, for: .normal)
        }
    }
    
    // Start tracking touch in control
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateShowHideButton(at: touch)
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
            updateShowHideButton(at: touch)
            sendActions(for: .touchUpInside)
        } else {
            sendActions(for: .touchUpOutside)
        }
    }
    
    // Cancel tracking
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }
    
    @objc private func determineStrength() {
        
        textField.text = password
        switch password.count {
        case 0...9:
            strengthDescriptionLabel.text = StrengthValue.weak.rawValue;
            weakView.backgroundColor = weakColor;
            UIView.animateKeyframes(withDuration: 0.50, delay: 0, options: [], animations: {
                self.weakView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
            }, completion: nil)
        case 10...19:
            strengthDescriptionLabel.text = StrengthValue.medium.rawValue;
            mediumView.backgroundColor = mediumColor;
            UIView.animateKeyframes(withDuration: 0.50, delay: 0, options: [], animations: {
                self.mediumView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
            }, completion: nil)
        default:
            strengthDescriptionLabel.text = StrengthValue.strong.rawValue;
            strongView.backgroundColor = strongColor;
            UIView.animateKeyframes(withDuration: 0.50, delay: 0, options: [], animations: {
                self.strongView.heightAnchor.constraint(equalToConstant: 8.0).isActive = true
            }, completion: nil)
            
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength()
        return true
    }
}
