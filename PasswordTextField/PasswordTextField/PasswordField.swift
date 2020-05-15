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
    
    private let componentDimension: CGFloat = 40.0
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
    private var textFieldContainer: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var passwordStrengthLabel = UILabel()
    private var passwordStrengthContainer = UILabel()
    private var stackView: UIStackView = UIStackView()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    
    func setup() {
        // Lay out your subviews here
        
        //titleLabel
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        titleLabel.text = "Enter Password"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        
        addSubview(textFieldContainer)
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldContainer.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        textFieldContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        textFieldContainer.layer.borderColor = UIColor.blue.cgColor
        textFieldContainer.layer.borderWidth = 1.0
        
        //passwordTextField
        textFieldContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 8).isActive = true
        textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 8).isActive = true
        textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -8).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -8).isActive = true
        
        textField.placeholder = "password"
        textField.becomeFirstResponder()
        
        
        // showHideButton
        textFieldContainer.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 8).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8).isActive = true
        
        showHideButton.setTitle("👁", for: .normal)
        
        addSubview(passwordStrengthLabel)
        passwordStrengthLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordStrengthLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordStrengthLabel.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainer.bottomAnchor, multiplier: 1).isActive = true
        passwordStrengthLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordStrengthLabel.text = "Too weak"
        passwordStrengthLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        
        
        
        addSubview(passwordStrengthContainer)
        
        passwordStrengthContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordStrengthContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordStrengthContainer.topAnchor.constraint(equalToSystemSpacingBelow: passwordStrengthLabel.bottomAnchor, multiplier: 1.0).isActive = true
        passwordStrengthContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordStrengthContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        passwordStrengthContainer.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: passwordStrengthContainer.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: passwordStrengthContainer.trailingAnchor, constant: 8).isActive = true
        stackView.topAnchor.constraint(equalTo: passwordStrengthContainer.topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: passwordStrengthContainer.bottomAnchor, constant: 8).isActive = true
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
//        let spacingOffset = componentDimension * CGFloat(2-1) + CGFloat(5) //look to use stride instead
        weakView.frame = weakView.frame.offsetBy(dx: 10, dy: 0)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.frame.size = CGSize(width: 60.0, height: 5.0)
        weakView.layer.backgroundColor = weakColor.cgColor
        
        mediumView.frame = mediumView.frame.offsetBy(dx: 75, dy: 0)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.frame.size = CGSize(width: 60.0, height: 5.0)
        mediumView.layer.backgroundColor = unusedColor.cgColor
        
        strongView.frame = mediumView.frame.offsetBy(dx: mediumView.bounds.maxX + 7, dy: 0)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.frame.size = CGSize(width: 60.0, height: 5.0)
        strongView.layer.backgroundColor = unusedColor.cgColor
    
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        
        stackView.addSubview(weakView)
        stackView.addSubview(mediumView)
        stackView.addSubview(strongView)
            
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
        
        if newText.count >= 5 {
            mediumView.backgroundColor = mediumColor
            passwordStrengthLabel.text = "Could be stronger"
        }
        
        //When the user taps the "return" key on the keyboard, the control should hide the keyboard and then signal to the containing view controller that the value of the password has changed using the target-action pattern (use the event type valueChanged). You'll need an IBAction that is wired to this event on the control in the view controller. When that event fires, simply print the password value and its strength to the console from the view controller.
        
        
        
//        if oldText.count <= 5 {
//
//
//        }
//        else if oldText.count <= 8 {
//
//        }
//        else {
//
//        }
//
        
        return true
    }
}
