//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "Too weak"
    case medium = "Moderate"
    case strong = "Strong password"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
    private var passwordHidden = true
    
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
        
        backgroundColor = bgColor
        
        // Add subviews
        addSubview(titleLabel)
        addSubview(textField)
//        textField.addSubview(showHideButton)
        addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(strengthDescriptionLabel)
        
        // Turn off Autoresizing Mask translation
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrain
        let widthBy6 = frame.width / 6
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 0.7),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
            
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: widthBy6),
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 1.7),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin * 1.7),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin / 2),
            mediumView.widthAnchor.constraint(equalToConstant: widthBy6),
            mediumView.topAnchor.constraint(equalTo: weakView.topAnchor),
            mediumView.bottomAnchor.constraint(equalTo: weakView.bottomAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin / 2),
            strongView.widthAnchor.constraint(equalToConstant: widthBy6),
            strongView.topAnchor.constraint(equalTo: weakView.topAnchor),
            strongView.bottomAnchor.constraint(equalTo: weakView.bottomAnchor),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin)
            
        ])
        
        // Initialize labels and text field
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        textField.placeholder = "Choose a strong password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.isSecureTextEntry = true
//        textField.delegate = self
        textField.isEnabled = true
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideTapped), for: .touchUpInside)
        strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
                
    }
    //adds custom labels etc, and makes this page the textfield delegate of the view.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.delegate = self
        setup()
    }
    //function to run the eye icon and present the text as secure or not.
    @objc private func showHideTapped() {
        if passwordHidden == true {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
        passwordHidden.toggle()
    }
    //checks the strength of the password dependant on the amount of letters.
    func strengthOf(_ password: String) -> PasswordStrength {
        var strength: PasswordStrength
        
        switch password.count {
        case 0...8:
            strength = .weak
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 9...12:
            strength = .medium
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        default:
            strength = .strong
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
        
        strengthDescriptionLabel.text = strength.rawValue
        
        if passwordStrength != strength {
            flare(strength)
        }
        
        return strength
    }
    //flare animation
    func flare(_ level: PasswordStrength) {
        var view: UIView
        
        switch level {
        case .weak:
            view = weakView
        case .medium:
            view = mediumView
        case .strong:
            view = strongView
        }
        
        let animationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.7) {
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.7)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                view.transform = .identity
            }
        }
        
        UIView.animateKeyframes(withDuration: 0.7, delay: 0, options: [], animations: animationBlock, completion: nil)
    }

}
//replaces, changes, and resets pasword strings and user text.
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        passwordStrength = strengthOf(newText)
        return true
    }
 //this is putting the user input as the password instance, and resigning the textfiled when return is hit.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password = textField.text ?? ""
        sendActions(for: [.valueChanged])
        textField.resignFirstResponder()
        return true
    }
}
