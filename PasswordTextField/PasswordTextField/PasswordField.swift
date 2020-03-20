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
    private let strengthDescriptionLabelFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)

    private let stackView = UIStackView()
    private let strengthFudge: CGFloat = 5
    private var passwordVisible = false
    private var passwordVisibleImage: UIImage!
    private var passwordHiddenImage: UIImage!

    func setup() {
        // Lay out your subviews here
        backgroundColor = bgColor

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
        textField.layer.cornerRadius = 4.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(keyPress(_:)), for: .editingChanged)

        // TODO: ? textFieldContainerHeight seems ignored here vs. textField.heightAnchor later
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                            constant: -standardMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true

        // ---- showHideButton ---------------------------------------
        passwordVisibleImage = UIImage(named: "eyes-open")!
        passwordHiddenImage  = UIImage(named: "eyes-closed")!
            
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.addTarget(self, action: #selector(revealButton(_:)), for: .touchUpInside)

        showHideButton.setImage(passwordHiddenImage, for: .normal)
        
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor,
                                                constant: -standardMargin).isActive = true
        showHideButton.widthAnchor.constraint(equalToConstant: passwordHiddenImage.size.width).isActive = true
        showHideButton.heightAnchor.constraint(equalToConstant: passwordHiddenImage.size.height).isActive = true

        // ---- weakView ---------------------------------------------
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.frame.size = colorViewSize
        weakView.backgroundColor = weakColor

        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                      constant: standardMargin + strengthFudge).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: standardMargin).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true

        // ---- mediumView -------------------------------------------
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.frame.size = colorViewSize
        mediumView.backgroundColor = unusedColor

        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                        constant: standardMargin + strengthFudge).isActive = true
        // TODO: ? Why isn't standardMargin negative
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor,
                                          constant: standardMargin).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true

        // ---- strongView -------------------------------------------
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.frame.size = colorViewSize
        strongView.backgroundColor = unusedColor

        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                        constant: standardMargin + strengthFudge).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor,
                                            constant: standardMargin).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true

        // ---- strengthDescriptionLabel -----------------------------
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = strengthDescriptionLabelFont

        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                                      constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor,
                                            constant: standardMargin).isActive = true

        // Initialize UI state
        handlePasswordVisible()
        updateStrengthMeter(letterCount: 0)
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
    
    // MARK: - Actions
    @objc func keyPress(_ sender: UITextField) {
        if let text = sender.text {
            updateStrengthMeter(letterCount: text.count)
        }
    }
    
    @objc func revealButton(_ sender: UIButton) {
        passwordVisible.toggle()

        handlePasswordVisible()
    }
    
    // MARK: - Methods

    private func updateStrengthMeter(letterCount count: Int) {
        
        switch count {
        case 20...Int.max: // Strong
            weakView.backgroundColor = strongColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong Password"
        case 10...19: // Medium
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could Be Stronger"
        case 0...9: // Weak
            fallthrough
        default:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too Weak"
        }
    }

    private func handlePasswordVisible() {
        if passwordVisible { // Show
            textField.isSecureTextEntry = false
            showHideButton.setImage(passwordVisibleImage, for: .normal)
        } else { // Hide
            textField.isSecureTextEntry = true
            showHideButton.setImage(passwordHiddenImage, for: .normal)
        }
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
