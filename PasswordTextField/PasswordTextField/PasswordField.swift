//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit



enum passwordStrength: String {
    case empty = ""
    case weak = "To Weak"
    case medium = "Could Be Stronger"
    case strong = "Strong Password"
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
    private var passwordTextContainerView:UIView = UIView()
   // private var passwordTextField: UITextField = UITextField()
   // private var showAndHideButton:UIButton = UIButton()
    //private var buttonView:UIView = UIView()
    
    
    @objc func showOrHidePassword(_ sender: UIButton){
        textField.isSecureTextEntry.toggle()
        print("BUTTON CLICKED")
        if textField.isSecureTextEntry{
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            print("BUTTON CLICKED")
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            print("BUTTON CLICKED")
        }
    }
    
    
    func setup() {
        // Lay out your subviews here
        ///TITLE LABEL
        
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topAnchor.constraint(equalTo: self.topAnchor),
            trailingAnchor.constraint(equalTo: self.trailingAnchor),
            heightAnchor.constraint(equalToConstant: 110)
            
        
        ])
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:standardMargin),
            
            titleLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: standardMargin),
            
            titleLabel.trailingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin)
            
            
        
        ])
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.text = "ENTER PASSWORD"
        
        
    ///pw
        
        addSubview(passwordTextContainerView)
        passwordTextContainerView.layer.borderColor = textFieldBorderColor.cgColor
        passwordTextContainerView.layer.borderWidth = 2.0
        passwordTextContainerView.layer.cornerRadius = 5.0
        
        passwordTextContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),
            passwordTextContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordTextContainerView.trailingAnchor.constraint(equalTo:titleLabel.trailingAnchor),
            passwordTextContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        
        ])
        
        // tf
        
        passwordTextContainerView.addSubview(textField)
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        textField.delegate = self
        textField.becomeFirstResponder()
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: passwordTextContainerView.topAnchor),
            textField.leadingAnchor.constraint(equalTo:passwordTextContainerView.leadingAnchor, constant: standardMargin),
            textField.bottomAnchor.constraint(equalTo:passwordTextContainerView.bottomAnchor, constant: -standardMargin),
            textField.trailingAnchor.constraint(equalTo: passwordTextContainerView.trailingAnchor, constant: -standardMargin)
        ])
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showOrHidePassword), for: .touchUpInside)
      
        
       
        /// Configure Strength Bar Views
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo:self.leadingAnchor),

            weakView.heightAnchor.constraint(equalToConstant: 6),
            weakView.widthAnchor.constraint(equalToConstant: 65)




        ])
        weakView.layer.cornerRadius = 6
        weakView.backgroundColor = unusedColor

        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: standardMargin),
            mediumView.leadingAnchor.constraint(equalTo:weakView.trailingAnchor),

            mediumView.heightAnchor.constraint(equalToConstant: 6),
            mediumView.widthAnchor.constraint(equalToConstant: 65)




        ])
        mediumView.layer.cornerRadius = 6
        mediumView.backgroundColor = unusedColor


               addSubview(strongView)
               strongView.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   strongView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: standardMargin),
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
        case 0:
            passwordStrength = .empty
        case 1...9:
            passwordStrength = .weak
            
        case 10 ... 15:
            passwordStrength = .medium
            
        case 15 ... 1000:
            passwordStrength = .strong
            
         default:
            passwordStrength = .empty
        }
        //self.password = password
        strengthBarBackground(passwordStrength)
        
        
    }
    
    func strengthBarBackground( _ passwordStrength: passwordStrength){
        switch passwordStrength {
            
        case .empty:
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor

            
        case .weak :
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = passwordStrength.rawValue
            
            UIView.animate(withDuration: 0.5, animations: {
                self.weakView.transform = CGAffineTransform(scaleX: 1, y:2)
                
            }) { (_) in
                UIView.animate(withDuration: 0.75) {
                    self.weakView.transform = .identity
                    }
                              }
            
        case .medium:
            weakView.backgroundColor = weakColor
              mediumView.backgroundColor = mediumColor
              strongView.backgroundColor = unusedColor
              strengthDescriptionLabel.text = passwordStrength.rawValue
            
            
            UIView.animate(withDuration: 0.5, animations: {
                self.mediumView.transform = CGAffineTransform(scaleX: 1, y:2)
                
            }) { (_) in
                UIView.animate(withDuration: 0.75) {
                    self.mediumView.transform = .identity
                    }
                              }
            
        case .strong:
            weakView.backgroundColor = weakColor
              mediumView.backgroundColor = mediumColor
              strongView.backgroundColor = strongColor
              strengthDescriptionLabel.text = passwordStrength.rawValue
            
            
            UIView.animate(withDuration: 0.5, animations: {
                self.strongView.transform = CGAffineTransform(scaleX: 1, y:2)
                
            }) { (_) in
                UIView.animate(withDuration: 0.75) {
                    self.strongView.transform = .identity
                    }
                              }
              
        }
    }
        
        
        
        
        
        
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.delegate = self
        setup()
        
    }
    
  
    
  
    }
    
    


extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        self.DeterminePassStrength(newText)
       
        return true
    }

}
