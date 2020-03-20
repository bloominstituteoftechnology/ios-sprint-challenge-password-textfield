//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable
class PasswordField: UIControl {
    
    // MARK: - Properties
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0  // FIXME: Use Me
    private let textFieldMargin: CGFloat = 6.0 // FIXME: Use Me
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1) // FIXME: Use Me
    
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
    
    private let stackView = UIStackView()

    func setup() {
        // Lay out your subviews here
        
        // ---- titleLabel -------------------------------------------
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.text = "Enter Password"

        titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                       constant: standardMargin).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: standardMargin).isActive = true
        
        // ---- textField --------------------------------------------
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.text = "See me?" // FIXME: Remove before flight

        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: standardMargin).isActive = true
        
        textField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: standardMargin).isActive = true

        textField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                            constant: standardMargin).isActive = true

        // ---- showHideButton ---------------------------------------
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        // ---- weakView ---------------------------------------------
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.frame.size = colorViewSize
        weakView.backgroundColor = unusedColor
        weakView.backgroundColor = weakColor // FIXME: Remove before flight

        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                      constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: standardMargin).isActive = true

        // ---- mediumView -------------------------------------------
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.frame.size = colorViewSize
        mediumView.backgroundColor = unusedColor
        mediumView.backgroundColor = mediumColor // FIXME: Remove before flight

        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                        constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor,
                                          constant: standardMargin).isActive = true

        // ---- strongView -------------------------------------------
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.frame.size = colorViewSize
        strongView.backgroundColor = unusedColor
        strongView.backgroundColor = strongColor // FIXME: Remove before flight

        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                        constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor,
                                            constant: standardMargin).isActive = true

        // ---- strengthDescriptionLabel -----------------------------
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = "Could Be Stronger" // FIXME: Remove before flight

        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                                      constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor,
                                            constant: standardMargin).isActive = true
    }
    
    // MARK: - Initializers
    
    // TODO: ? This wasn't here but didn't seem necessary. Why?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
        return true
    }
}
