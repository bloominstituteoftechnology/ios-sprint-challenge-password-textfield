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

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordShow: Bool = false
    private (set) var passwordStrength: PasswordStrength = .weak
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
    
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
    
    
    private func updateButtonImage() {

        if passwordShow == true {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
            print("True")
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
            print("False")
        }
    }//
    

    
    func setup() {
        self.backgroundColor = bgColor
     
        configureTitle()
        configureTextField()
        configureShowIcon()
        configureStrengthColors()
        configureStrengthDescriptionLabel()
        
    }//
    
    private func configureTitle() {
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
        ])
    }//
    
    private func configureTextField() {
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
        
        textField.isSecureTextEntry = true

        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 2.0
        textField.placeholder = "Password"
        
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        
        textField.delegate = self
  
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
    }//
    
    
    private func configureShowIcon() {
//        showHideButton.isUserInteractionEnabled = true
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showHideButton.frame = CGRect(x: textField.frame.size.width - 25, y: 5, width: 25, height: 25)
        
        showHideButton.addTarget(self, action: #selector(changeShowHideButton), for: .touchUpInside)
        
        
//        addSubview(showHideButton)
//        showHideButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -15),
//            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
//        ])
        
        
    }//
    
    
    private func configureStrengthColors() {
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // weakView Constrains
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            // mediumView Constrains
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 5),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 5),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
    }//
    
    private func configureStrengthDescriptionLabel() {
        strengthDescriptionLabel.text = "Enter Password"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textAlignment = .right
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 1.5),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textFieldMargin),
        ])
    }//
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
   @objc func changeShowHideButton() {
          passwordShow.toggle()
          updateButtonImage()
      }
    
    
    private func updatePasswords(strength: PasswordStrength) {
        switch strength {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Weak Password"
            
            viewsAnimations(weakView)
            
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Medium Password"
            
            viewsAnimations(mediumView)
            
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong Password"
            
            viewsAnimations(strongView)
        }
    }
    
    private func viewsAnimations(_ colorView: UIView) {
        
        UIView.animate(withDuration: 0.2, animations: {
            colorView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                colorView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
        
    }//
    
    
    private func passwordStrength(password: String) {
        switch password.count {
        case 0...9:
            updatePasswords(strength: .weak)
        case 10...19:
            updatePasswords(strength: .medium)
        default:
            updatePasswords(strength: .strong)
        }
    }
    
} // CLASS

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength(password: newText)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        guard let password = textField.text else { return false }
        print(password)
        return false
    }
}
