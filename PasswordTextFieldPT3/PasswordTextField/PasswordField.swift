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
    private let colorViewRadius: CGFloat = 2.0
    
    // Strength checkpoints
    private let strengthMin: Int = 1
    private let strengthMed: Int = 9
    private let strengthMax: Int = 18

    
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
    private var buttonView: UIView = UIView()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    private let strengthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 2.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var passwordShowing: Bool = false
    
    func setup() {
        // Lay out your subviews here
        // Title Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
        ])
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.text = "ENTER PASSWORD"
        
        // Text Field
        addSubview(textField)
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
// Check this feature
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = standardMargin
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.backgroundColor = bgColor
        textField.directionalLayoutMargins.trailing = standardMargin
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
// Check these constraints
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
//        addSubview(buttonView)
//        NSLayoutConstraint.activate([
//            buttonView.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
//            buttonView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
//            buttonView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
//            buttonView.widthAnchor.constraint(equalToConstant: textFieldContainerHeight)
//        ])
        
        // Show/Hide Button
        addSubview(showHideButton)
        //        showHideButton.frame = CGRect(x: textField.frame.maxX - 50.0, y: textField.frame.minY, width: 50.0, height: 50.0)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            showHideButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
//            showHideButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
//        ])
        NSLayoutConstraint.activate([
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        showHideButton.isUserInteractionEnabled = true
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        // StackView
        addSubview(strengthStackView)
        NSLayoutConstraint.activate([
            strengthStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strengthStackView.leadingAnchor.constraint(equalTo: textField.leadingAnchor)
        ])
        strengthStackView.addArrangedSubview(weakView)
        strengthStackView.addArrangedSubview(mediumView)
        strengthStackView.addArrangedSubview(strongView)
        
        // Constraint and create strength views
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weakView.heightAnchor.constraint(equalToConstant: 5.0),
            weakView.widthAnchor.constraint(equalToConstant: 60.0)
        ])
//        weakView.systemLayoutSizeFitting(colorViewSize)
//        weakView.sizeThatFits(colorViewSize)
        weakView.backgroundColor = unusedColor
        weakView.layer.cornerRadius = colorViewRadius
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.systemLayoutSizeFitting(colorViewSize)
        NSLayoutConstraint.activate([
            mediumView.heightAnchor.constraint(equalToConstant: 5.0),
            mediumView.widthAnchor.constraint(equalToConstant: 60.0)
        ])
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = colorViewRadius
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.systemLayoutSizeFitting(colorViewSize)
        NSLayoutConstraint.activate([
            strongView.heightAnchor.constraint(equalToConstant: 5.0),
            strongView.widthAnchor.constraint(equalToConstant: 60.0)
        ])
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = colorViewRadius
        
        // Strength label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strengthStackView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strengthStackView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
        ])
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "Strength Level"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func showPassword() {
//        let touchPoint = touch.location(in: self)
        print("Button touched")
 //       if touchPoint.x <= showHideButton.frame.maxX && touchPoint.x >= showHideButton.frame.maxX {
        passwordShowing.toggle()
        showHideButton.setImage(UIImage(named: passwordShowing ? "eyes-open" : "eyes-closed"), for: .normal)
        textField.isSecureTextEntry.toggle()
//        }
    }
    
    private func animateStrength(_ strengthView: UIView) {
        strengthView.transform = CGAffineTransform(scaleX: 1.0, y: 1.15)
        UIView.animate(withDuration: 1.5) {
            strengthView.transform = .identity
        }
    }
    
    func determineStrength(for textLength: Int) {
        switch textLength {
        case strengthMin:
            animateStrength(weakView)
        case strengthMed:
            animateStrength(mediumView)
        case strengthMax:
            animateStrength(strongView)
        default:
            return
        }
        
        switch textLength {
        case strengthMin..<strengthMed:
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Too weak"
            strength = .weak
            
        case strengthMed..<strengthMax:
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could be stronger"
            strength = .medium
            
        case strengthMax..<36:
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
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)

        determineStrength(for: newText.count)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let password = textField.text, !password.isEmpty {
            self.password = password
        }
        sendActions(for: .valueChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        if let password = textField.text, !password.isEmpty {
            self.password = password
        }
        return true
    }
}
