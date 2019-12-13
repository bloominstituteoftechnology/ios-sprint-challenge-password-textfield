//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

//@IBDesignable

enum passwordStrength: String {
    case weak = "To Weak"
    case medium = "Could Be Stronger"
    case strong = "Strong Password"
}
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
    private var passwordTextContainerView:UIView = UIView()
    private var passwordTextField: UITextField = UITextField()
    private var showAndHideButton:UIButton = UIButton(type: .system)
    private var buttonView:UIView = UIView()
    
    
    @objc func showOrHidePassword(){
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry{
            showAndHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    
    func setup() {
        // Lay out your subviews here
        ///TITLE LABEL
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:130 + standardMargin),
            
            titleLabel.leadingAnchor.constraint(equalTo:leadingAnchor, constant: standardMargin),
            
            titleLabel.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -standardMargin)
            
            
        
        ])
        titleLabel.text = "ENTER PASSWORD"
      
        
        /// PasswordTextContainerView
        addSubview(passwordTextContainerView)
        passwordTextContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextContainerView.backgroundColor = bgColor
        NSLayoutConstraint.activate([
            
               passwordTextContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
               
            passwordTextContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            
            passwordTextContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            passwordTextContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            
            
])
        
        passwordTextContainerView.layer.borderColor = textFieldBorderColor.cgColor
        passwordTextContainerView.layer.borderWidth = 3
        passwordTextContainerView.layer.cornerRadius = 6
        
        /// Add the passwords text field to the password container view
           passwordTextContainerView.addSubview(passwordTextField)
            
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                passwordTextField.topAnchor.constraint(equalTo: passwordTextContainerView.topAnchor, constant: standardMargin),
                
                passwordTextField.leadingAnchor.constraint(equalTo: passwordTextContainerView.leadingAnchor, constant: standardMargin),
                
        
                
                passwordTextField.widthAnchor.constraint(equalToConstant: 250),
                passwordTextField.bottomAnchor.constraint(equalTo: passwordTextContainerView.bottomAnchor, constant: -standardMargin)
            
            
            
            
            ])
            
            passwordTextField.isSecureTextEntry = true
            passwordTextField.delegate = self
            passwordTextField.placeholder = "Password"
        passwordTextField.becomeFirstResponder()

        
        /// View to house Button
        
        passwordTextContainerView.addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.topAnchor.constraint(equalTo: passwordTextContainerView.topAnchor, constant: standardMargin).isActive = true
        buttonView.leadingAnchor.constraint(equalTo:passwordTextField.trailingAnchor, constant: standardMargin).isActive = true
        buttonView.trailingAnchor.constraint(equalTo:passwordTextContainerView.trailingAnchor, constant: -standardMargin).isActive = true
        
        buttonView.bottomAnchor.constraint(equalTo:passwordTextContainerView.bottomAnchor, constant:standardMargin).isActive = true
        
        
        
        
        /// BUTTON
        
        buttonView.addSubview(showAndHideButton)
        showAndHideButton.translatesAutoresizingMaskIntoConstraints = false
        showAndHideButton.topAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        showAndHideButton.leadingAnchor.constraint(equalTo:buttonView.leadingAnchor).isActive = true
        showAndHideButton.trailingAnchor.constraint(equalTo:buttonView.trailingAnchor).isActive = true
        showAndHideButton.bottomAnchor.constraint(equalTo:buttonView.bottomAnchor).isActive = true
     
        showAndHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showAndHideButton.addTarget(self, action: #selector(showOrHidePassword), for: .touchUpInside)
        
        /// Configure Strength Bar Views
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: passwordTextContainerView.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo:passwordTextContainerView.leadingAnchor),
            
            weakView.heightAnchor.constraint(equalToConstant: 6),
            weakView.widthAnchor.constraint(equalToConstant: 65)
            
            
        
        
        ])
        weakView.layer.cornerRadius = 6
        weakView.backgroundColor = unusedColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: passwordTextContainerView.bottomAnchor, constant: standardMargin),
            mediumView.leadingAnchor.constraint(equalTo:weakView.trailingAnchor),
            
            mediumView.heightAnchor.constraint(equalToConstant: 6),
            mediumView.widthAnchor.constraint(equalToConstant: 65)
            
            
        
        
        ])
        mediumView.layer.cornerRadius = 6
        mediumView.backgroundColor = unusedColor
        
        
               addSubview(strongView)
               strongView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   strongView.topAnchor.constraint(equalTo: passwordTextContainerView.bottomAnchor, constant: standardMargin),
                   strongView.leadingAnchor.constraint(equalTo:mediumView.trailingAnchor),
                   
                   strongView.heightAnchor.constraint(equalToConstant: 6),
                   strongView.widthAnchor.constraint(equalToConstant: 65)
                   
                   
               
               
               ])
               strongView.layer.cornerRadius = 6
               strongView.backgroundColor = unusedColor
        
 
        
    
    
    /// add label for password strength description
   addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordTextContainerView.bottomAnchor, constant: standardMargin),
            
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin)
        
        
        
        
        ])
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = ""
        
    
    
    }
    
    
    func DeterminePassStrength(_ password: String) {
        var passwordStrength: passwordStrength
        
        switch password.count {
        case 0...9:
            passwordStrength = .weak
            
        case 10 ... 19:
            passwordStrength = .medium
            
        default:
            passwordStrength = .strong
        }
        self.password = password
        strengthBarBackground(passwordStrength)
        sendActions(for:[.valueChanged])
        
    }
    
    func strengthBarBackground( _ passwordStrength: passwordStrength){
        switch passwordStrength {
        case .weak :
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = passwordStrength.rawValue
            
        case .medium:
            weakView.backgroundColor = weakColor
              mediumView.backgroundColor = mediumColor
              strongView.backgroundColor = unusedColor
              strengthDescriptionLabel.text = passwordStrength.rawValue
            
        case .strong:
            weakView.backgroundColor = weakColor
              mediumView.backgroundColor = mediumColor
              strongView.backgroundColor = strongColor
              strengthDescriptionLabel.text = passwordStrength.rawValue
              
        }
    }
        
        
        
        
        
        
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        DeterminePassStrength(newText)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         endEditing(true)
    textField.resignFirstResponder()
         return true
     }
}


/*
 NSLayoutConstraint.activate([
         colorWheel.topAnchor.constraint(equalTo: topAnchor),
         colorWheel.leadingAnchor.constraint(equalTo: leadingAnchor),
         colorWheel.trailingAnchor.constraint(equalTo: trailingAnchor),
         colorWheel.heightAnchor.constraint(equalTo: colorWheel.widthAnchor)
     ])
 */

