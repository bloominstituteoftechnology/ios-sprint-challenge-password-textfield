//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength {
    case weak
    case medium
    case strong
}

//@IBDesignable
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
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
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
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
        ])
        
        // textField
        textField.borderStyle = .line
        textField.isEnabled = true
        textField.isSecureTextEntry = true
        textField.becomeFirstResponder()
        
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            textField.heightAnchor.constraint(equalToConstant: 40)
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
            weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            weakView.heightAnchor.constraint(equalToConstant: 10),
            weakView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // medium view
        mediumView.backgroundColor = mediumColor
        NSLayoutConstraint.activate([
            mediumView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 8),
            mediumView.heightAnchor.constraint(equalToConstant: 10),
            mediumView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // strong view
        strongView.backgroundColor = strongColor
        NSLayoutConstraint.activate([
            strongView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 8),
            strongView.heightAnchor.constraint(equalToConstant: 10),
            strongView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // strength description label
        strengthDescriptionLabel.text = "Too Weak"
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 8),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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

extension UIView {
    // Animate the change
    func animateView() {
        func increaseHeight() { transform = CGAffineTransform(scaleX: 1.0, y: 1.3)}
        func restorHeight() { transform = .identity}
        
        UIView.animate(withDuration: 0.3,
                       animations: { increaseHeight() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { restorHeight() }})
    }
}
