//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit


enum passwordStrenght: String {
    case weak = "Password is to weak"
    case medium = "Password is okay"
    case strong = "Good password"
}

@IBDesignable
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
    
    private var passwordViewContainer: UIView = UIView()
    private var eyeImage: UIImageView = UIImageView()
    private var hidePassword: Bool = true
    
    
    func setup() {
        // Lay out your subviews here
        
        layer.cornerRadius = 0
        backgroundColor = bgColor
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     topAnchor.constraint(equalTo: self.topAnchor),
                                     trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     heightAnchor.constraint(equalToConstant: 109.0)
        ])
        
        
        //Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        
        //Password Containter
        addSubview(passwordViewContainer)
        passwordViewContainer.layer.borderColor = textFieldBorderColor.cgColor
        passwordViewContainer.layer.borderWidth = 1.5
        passwordViewContainer.layer.cornerRadius = 5.0
        passwordViewContainer.translatesAutoresizingMaskIntoConstraints = false
        passwordViewContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordViewContainer.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        passwordViewContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordViewContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        
        //textField
        passwordViewContainer.addSubview(textField)
        textField.placeholder = "Enter your Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.leadingAnchor.constraint(equalTo: passwordViewContainer.leadingAnchor, constant: standardMargin).isActive = true
        textField.topAnchor.constraint(equalTo: passwordViewContainer.topAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: passwordViewContainer.trailingAnchor, constant: -standardMargin).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: -standardMargin).isActive = true
        
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHiddenText), for: .touchUpInside)
        
        
        
        
        
        
        //weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: standardMargin * 2).isActive = true
        weakView.leadingAnchor.constraint(equalTo: passwordViewContainer.leadingAnchor, constant: standardMargin).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        weakView.backgroundColor = unusedColor
        
        //medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: standardMargin * 2 ).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        mediumView.backgroundColor = unusedColor
        
        //strong view
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: standardMargin * 2).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        strongView.backgroundColor = unusedColor
        
        // Strenght label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordViewContainer.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: passwordViewContainer.trailingAnchor, constant: -standardMargin).isActive = true
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = " "
        strengthDescriptionLabel.textColor = labelTextColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    @objc private func showHiddenText() {
        textField.isSecureTextEntry.toggle()
        
        if textField.isSecureTextEntry == true  {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-opned"), for: .normal)
        }
    }
    
    
    func passwordStrenght(_ password: String) {
        var passwordStrenght: passwordStrenght
        switch password.count {
        case 0...4 :
            passwordStrenght = .weak
            if weakView.backgroundColor != weakColor {
                weakView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                UIView.animate(withDuration: 0.3) {
                    self.weakView.transform = .identity
                }
            }
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = passwordStrenght.rawValue
            
        case 5...7 :
            passwordStrenght = .medium
            if mediumView != mediumColor {
                mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                UIView.animate(withDuration: 0.3) {
                    self.mediumView.transform = .identity
                }
            }
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = passwordStrenght.rawValue
            
            
            
            
            
        default:
            passwordStrenght = .strong
            if strongView != strongColor {
                strongView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                UIView.animate(withDuration: 0.3) {
                    self.strongView.transform = .identity
                }
            }
            strongView.backgroundColor = weakColor
            strongView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = passwordStrenght.rawValue
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        passwordStrenght(newText)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let password = textField.text, !password.isEmpty {
            self.password = password
            sendActions(for: .valueChanged)
        }
        return true
    }
    
    
    
    
}
