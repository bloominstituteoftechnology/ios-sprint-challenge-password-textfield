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
    // set initial condition of PW strength
    private (set) var passwordStrength: PasswordStrength = .weak
    // set initial status of Show Pass
    private (set) var showPassword: Bool = false
    
    
    
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
    
    // handle image for button based on toggle condition as well as the secure text status
    
    
    private func updateShowHideButtonImage() {
        
        let showImage = UIImage(named: "eyes-open.png")
        let hideImage = UIImage(named: "eyes-closed.png")
     
        if !showPassword {
            textField.isSecureTextEntry = true
            showHideButton.setImage(hideImage, for: .normal)
        } else {
            textField.isSecureTextEntry = false
            showHideButton.setImage(showImage, for: .normal)
        }
    }
    
    
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    
  //func viewDidAppear() {
       //   showHideButton.setImage(UIImage(named:"eye-closed.png"), for: .normal)
    //}

    
    func setup() {
        // Lay out your subviews here
        // Add titleLabel info
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        
        // Add textField view including button placement
        textField.placeholder = "Password"
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 8
        textField.isUserInteractionEnabled = true
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        
        
        //add button info   Need to FIX, this does not show up until clicked
        showHideButton.setImage(UIImage(named:"eye-closed.png"), for: .normal)
        showHideButton.addTarget(self, action: #selector(toggleShowPassword), for: .touchUpInside)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        
        
        // add weak etc. View info, default setting is weak color for weak, but unused for others
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = 2.0
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 2.0
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 2.0
        
        // strengthDescriptionLabel
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = "Too weak"
        
        
        
        
        
        self.backgroundColor = bgColor
        
        
        
        
        
        
        
        // Add views
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
      
       
        
        // add constraints
        
        
        
        // label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo:topAnchor , constant: standardMargin),
    
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
            
        ])
        
        // textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin ),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        
        
        
        
        
        // strength Views
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: weakView.topAnchor),
            mediumView.bottomAnchor.constraint(equalTo: weakView.bottomAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2.5 ),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        NSLayoutConstraint.activate([
            strongView.topAnchor.constraint(equalTo: weakView.topAnchor),
            strongView.bottomAnchor.constraint(equalTo: weakView.bottomAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2.5),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        NSLayoutConstraint.activate([
            
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 2.5),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor)
        ])
        
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    @objc func toggleShowPassword() {
        showPassword.toggle()
        updateShowHideButtonImage()
    }
    
    
    
    
    
    
    
    private func passwordStatus(password: String) {
        // based solely on count in password string for now
        switch password.count {
        case 0...9:
            updatePasswordStatus(strengthStatus: .weak)
            
        case 10:
            updatePasswordStatus(strengthStatus: .medium)
            
            pulseColor(view: mediumView)
            
        case 11...19:
            updatePasswordStatus(strengthStatus: .medium)
        
        case 20:
             updatePasswordStatus(strengthStatus: .strong)
             pulseColor(view: strongView)
       
             
            
        default:
            updatePasswordStatus(strengthStatus: .strong)
        }
    }
    
    
    private func updatePasswordStatus(strengthStatus: PasswordStrength){
        
        switch strengthStatus {
        case .weak:
            strengthDescriptionLabel.text = "Too weak"
            
        case .medium:
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could be stronger"
           
        case .strong:
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
       
            
            
        }
        
    }

        
        func pulseColor(view : UIView) {
            
            func pulse() { view.transform = CGAffineTransform(scaleX: 1.2, y: 1.3)}
            
            func revert() { view.transform = .identity}
       
            UIView.animate(withDuration: 0.2,
                           animations: {pulse() },
                           
                           completion: { _ in UIView.animate(withDuration: 0.2) {revert()}}
         )
        }
        


    
    
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        passwordStatus(password: newText)
        return true
    }
 
    
}


