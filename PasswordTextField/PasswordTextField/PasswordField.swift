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
    private (set) var strength: Strength = .weak
    
    enum Strength: String {
        case weak = "Too Weak"
        case medium = "Could Be Stronger"
        case strong = "Strong Password"
    }
    
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
    
    private var textFieldContainer: UIView = UIView()
    
    private var textIsHidden: Bool = false
    private var oldStrength: Strength = .weak
    
    func setup() {
        
        isUserInteractionEnabled = true
        
        backgroundColor = bgColor
        
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.text = "Enter Password"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)])
        
        textFieldContainer.layer.cornerRadius = 8
        textFieldContainer.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainer.layer.borderWidth = 3
        addSubview(textFieldContainer)
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)])
        
        showHideButton.contentMode = .scaleAspectFit
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHide), for: .touchUpInside)
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showHideButton.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -textFieldMargin)])
        
        textField.placeholder = "password"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.delegate = self
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: textFieldContainer.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: textFieldMargin),
            textField.widthAnchor.constraint(equalToConstant: 250)])
        
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = 2
        weakView.frame = CGRect(x: standardMargin, y: self.bounds.size.height - 16, width: 50, height: 5)
        addSubview(weakView)
        
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 2
        mediumView.frame = CGRect(x: standardMargin + 52, y: self.bounds.size.height - 16, width: 50, height: 5)
        addSubview(mediumView)
        
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 2
        strongView.frame = CGRect(x: standardMargin + (2 * 52), y: self.bounds.size.height - 16, width: 50, height: 5)
        addSubview(strongView)
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = strength.rawValue
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin)])

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc private func showHide() {
        switch textIsHidden {
        case true:
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
            textIsHidden = false
        case false:
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
            textIsHidden = true
        }
    }
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        checkStrength(password)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendActions(for: .valueChanged)
        return true
    }
    
    func checkStrength(_ password: String) {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: password.count)
        let wordRange = checker.rangeOfMisspelledWord(in: password, range: range, startingAt: 0, wrap: false, language: "en")
        switch password.count {
        case 10...19:
            oldStrength = strength
            if wordRange.location == NSNotFound {
                strength = .weak
                mediumView.backgroundColor = unusedColor
            } else {
                strength = .medium
                mediumView.backgroundColor = mediumColor
            }
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = strength.rawValue
            if oldStrength != strength {
                mediumView.performFlare()
            }
        case 20...:
            oldStrength = strength
            if wordRange.location == NSNotFound {
                strength = .medium
                strongView.backgroundColor = unusedColor
            } else {
                strength = .strong
                strongView.backgroundColor = strongColor
            }
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = strength.rawValue
            if oldStrength != strength {
                strongView.performFlare()
            }
        default:
            oldStrength = strength
            strength = .weak
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = strength.rawValue
            if oldStrength != strength {
                weakView.performFlare()
            }
        }
    }
    
}

extension UIView {
    func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
