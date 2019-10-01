//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum Strength {
    case none
    case weak
    case medium
    case strong
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var strength: Strength = .none
    
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
    
    private let passwordStrengthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 2.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setup() {
        // Lay out your subviews here
        self.backgroundColor = unusedColor
        // TITLE LABEL
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
        ])
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.text = "ENTER PASSWORD"
        
        // TEXTFIELD
        addSubview(textField)
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = standardMargin
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.backgroundColor = bgColor
        textField.layoutMargins.left = 2 * textFieldMargin
//        textField.layoutMargins.right = 2 * textFieldMargin
//        textField.clearsOnBeginEditing = true
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
        ])
        
        // SHOW/HIDE BUTTON
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        showHideButton.isUserInteractionEnabled = true
        showHideButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
//        textField.rightView = showHideButton
//        textField.rightViewMode = .always
        
        // ADD STACKVIEW
        addSubview(passwordStrengthStackView)
        NSLayoutConstraint.activate([
            passwordStrengthStackView.centerYAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20.0),
            passwordStrengthStackView.leadingAnchor.constraint(equalTo: textField.leadingAnchor)
        ])
        passwordStrengthStackView.addArrangedSubview(weakView)
        passwordStrengthStackView.addArrangedSubview(mediumView)
        passwordStrengthStackView.addArrangedSubview(strongView)

        // WEAK VIEW
//        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
//            weakView.centerYAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5 / 2 + standardMargin),
            weakView.heightAnchor.constraint(equalToConstant: 5.0),
            weakView.widthAnchor.constraint(equalToConstant: 60.0)
//            weakView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
//        weakView.systemLayoutSizeFitting(colorViewSize)
        weakView.backgroundColor = unusedColor
        weakView.layer.cornerRadius = 2.0
        
        // MEDIUM VIEW
//        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: textFieldMargin),
//            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.heightAnchor.constraint(equalToConstant: 5.0),
            mediumView.widthAnchor.constraint(equalToConstant: 60.0)
        ])
//        mediumView.sizeThatFits(colorViewSize)
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 2.0
        
        // STRONG VIEW
//        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: textFieldMargin),
//            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.heightAnchor.constraint(equalToConstant: 5.0),
            strongView.widthAnchor.constraint(equalToConstant: 60.0)
        ])
//        strongView.sizeThatFits(colorViewSize)
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 2.0
        
        // STRENGTH DESCRIPTION LABEL
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: passwordStrengthStackView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: passwordStrengthStackView.trailingAnchor, constant: standardMargin)
        ])
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "Strength Level"
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
        determineStrength(newText.count)
        
        return true
    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("Did Begin was called")
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("Did end was called")
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let password = textField.text, !password.isEmpty {
            self.password = password
        }
        return true
    }

    private func animateStrength(_ strengthView: UIView) {
        strengthView.transform = CGAffineTransform(scaleX: 1.0, y: 1.09)
        UIView.animate(withDuration: 1.5, animations: { strengthView.transform = .identity }, completion: nil)
    }
    
    func determineStrength(_ textLength: Int) {
        if textLength == 1 {
            animateStrength(weakView)
        } else if textLength == 9 {
            animateStrength(mediumView)
        } else if textLength == 18 {
            animateStrength(strongView)
        }
        
        switch textLength {
        case 1..<9:
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Too weak"
            strength = .weak
            
        case 9..<18:
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could be stronger"
            strength = .medium

        case 18..<36:
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
            strength = .strong

        default:
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strength = .none
        }
        
        
    }
    
    @objc func showHidePassword(_ sender: UIButton) {
        if sender == showHideButton {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.textContentType = .none
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.textContentType = .password
        }
    }
}
