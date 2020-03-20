//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
}

//@IBDesignable
class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
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
        
        //view
        
        backgroundColor = bgColor
        // Add subviews
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        // Turn off translates auto resize
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints:
        
        // titleLabel
        titleLabel.text = "ENTER PASSWORD: "
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin)
        ])
        
        // textField
        textField.isEnabled = true
        textField.isSecureTextEntry = true
        textField.becomeFirstResponder()
        textField.backgroundColor = bgColor
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // showHideButton
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: CGFloat(textField.frame.size.width - 40), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        showHideButton.addTarget(self, action: #selector(toggleShowHideButton), for: .touchUpInside)
        
        // weak view
        weakView.backgroundColor = weakColor
        NSLayoutConstraint.activate([
            weakView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        // medium view
        mediumView.backgroundColor = mediumColor
        NSLayoutConstraint.activate([
            mediumView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        // strong view
        strongView.backgroundColor = strongColor
        NSLayoutConstraint.activate([
            strongView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
        
        // strength description label
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override var intrinsicContentSize: CGSize {
        let width = 150
        let height = 150
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Actions
    
    //toggle showHideButton
    @objc private func toggleShowHideButton() {
        if textField.isSecureTextEntry == true {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    private func determineStrength(ofPassword password: String) {
        if password.count < 9,
            passwordStrength != .weak {
            animateView(view: weakView)
            passwordStrength = .weak
            strengthDescriptionLabel.text = "Too weak"
        } else if password.count >= 9,
            password.count < 20,
            passwordStrength != .medium {
            animateView(view: mediumView)
            passwordStrength = .medium
            strengthDescriptionLabel.text = "Could be stronger"
        } else if password.count >= 20,
            passwordStrength != .strong {
            animateView(view: strongView)
            passwordStrength = .strong
            strengthDescriptionLabel.text = "Strong password"
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength(ofPassword: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        password = text
        sendActions(for: [.touchUpInside, .touchUpOutside, .valueChanged])
        return true
    }
}

extension UIView {
    // Animate the change
    func animateView(view: UIView) {
        func increaseHeight() { view.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)}
        func restorHeight() { view.transform = .identity}
        
        UIView.animate(withDuration: 0.3,
                       animations: { increaseHeight() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { restorHeight() }})
    }
}
