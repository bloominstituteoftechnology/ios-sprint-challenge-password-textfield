//
//  PasswordControl.swift
//  PasswordTextField
//
//  Created by Chris Gonzales on 2/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit


class PasswordField: UIControl {
    
    // MARK: - Properties
    
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
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Subview Setup
    
    func setup() {
        frame = CGRect(x: 0, y: 0, width: bounds.width, height: 200)
        
        // titleLabel
        titleLabel.text = "Enter Password"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                        constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                            constant: standardMargin).isActive = true
        
        textField = UITextField(frame: CGRect(x: 0,
                                              y: 30,
                                              width: 250,
                                              height: 40))
        addSubview(textField)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.placeholder = "Enter Password"
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                           constant: standardMargin).isActive = true
        
        
        // showHideButton
        showHideButton = UIButton(type: .system)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor,
                                                constant: standardMargin).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                               constant: 70).isActive = true
        showHideButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        showHideButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        showHideButton.setImage(UIImage(named: "eyes-closed"),
                                for: .normal)
        showHideButton.setImage(UIImage(named: "eyes-open"),
                                for: .selected)
        showHideButton.isEnabled = true
        
        // weakView
        weakView = UIView(frame: CGRect(x: 0, y: 0,
                                        width: colorViewSize.width,
                                        height: colorViewSize.height))
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.backgroundColor = unusedColor
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                      constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                          constant: standardMargin).isActive  = true
        
        // mediumView
        mediumView = UIView(frame: CGRect(x: 0, y: 0,
                                          width: colorViewSize.width,
                                          height: colorViewSize.height))
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.backgroundColor = unusedColor
        mediumView.topAnchor.constraint(equalTo: weakView.topAnchor).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor,
                                            constant: standardMargin).isActive = true
        
        // strongView
        strongView = UIView(frame: CGRect(x: 0, y: 0,
                                          width: colorViewSize.width,
                                          height: colorViewSize.height))
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.backgroundColor = unusedColor
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                      constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalToSystemSpacingAfter: mediumView.trailingAnchor,
                                            multiplier: standardMargin).isActive = true
        
        // strengthDescriptionLabel
        strengthDescriptionLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                         width: 40,
                                                         height: 20))
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.text = "placeholder"
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor,
                                                          constant: standardMargin).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                                      constant: standardMargin).isActive = true
        
        
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        
        // TODO: send new text to the determine strength method
        testPasswordStrength(password: newText)
        
        return true
    }
    
    func testPasswordStrength(password: String){
        let count = password.count
        
        if count < 10{
            weakView.backgroundColor = weakColor
        } else if count >= 9 && count < 20 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
        } else if count > 20 {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
    
}

enum PasswordStrengthText: String {
    case weak = "too weak"
    case mid = "could be stronger"
    case strong = "strong password"
}
