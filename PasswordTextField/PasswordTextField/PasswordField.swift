
//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

//SPRINTCHALLENGE REDO

class PasswordField: UIControl {
    
    private (set) var password: String = ""
    
    private var standardMargin: CGFloat = 8.0
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
    private var passwordContainerView: UIView = UIView()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private (set) var defaultStrength: PasswordStrength = .weak
    private var showingPassword = false
    
    
    
    //MARK: - Setup
    
    func setup() {
        
        
        
        //MARK:       titleLabel
        
        titleLabel.text = " ENTER PASSWORD "
        titleLabel.textAlignment = .center
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin)
           ])
        
        
        addSubview(passwordContainerView)
        passwordContainerView.translatesAutoresizingMaskIntoConstraints = false
        passwordContainerView.layer.borderWidth = 1.5
        passwordContainerView.layer.cornerRadius = 5
        passwordContainerView.layer.borderColor = textFieldBorderColor.cgColor
        passwordContainerView.backgroundColor = bgColor
        
        NSLayoutConstraint.activate([
            passwordContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            passwordContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            passwordContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            passwordContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        //MARK:        textField
        
        passwordContainerView.addSubview(textField)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.delegate = self
        
        NSLayoutConstraint.activate([
        textField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor, constant: textFieldMargin),
        textField.leadingAnchor.constraint(equalTo: passwordContainerView.leadingAnchor, constant: textFieldMargin),
        passwordContainerView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldMargin)
        ])
        //MARK: Button
        
        
        passwordContainerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        showHideButton.bottomAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: -1).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        
  
        //        N
        //
        //MARK:        Views
        
        weakView.layer.backgroundColor = weakColor.cgColor
        weakView.backgroundColor = weakColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(weakView)
        
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        //        NSLayoutConstraint(item: weakView,
        //                           attribute: .top,
        //                           relatedBy: .equal,
        //                           toItem: textField,
        //                           attribute: .bottom,
        //                           multiplier: 1,
        //                           constant: 40).isActive = true
        
        //        weakView.trailingAnchor.constraint(equalTo: weakView.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
        
        
        mediumView.layer.backgroundColor = mediumColor.cgColor
        mediumView.backgroundColor = mediumColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        self.addSubview(mediumView)
        
        //        NSLayoutConstraint(item: mediumView,
        //                           attribute: .top,
        //                           relatedBy: .equal,
        //                           toItem: textField,
        //                           attribute: .bottom,
        //                           multiplier: 1,
        //                           constant: 40).isActive = true
        //
        //
        //
        //        NSLayoutConstraint(item: mediumView,
        //                           attribute: .leading,
        //                           relatedBy: .equal,
        //                           toItem: self,
        //                           attribute: .leading,
        //                           multiplier: 1,
        //                           constant: 70).isActive = true
        //
        
        strongView.layer.backgroundColor = strongColor.cgColor
        strongView.backgroundColor = strongColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.addSubview(strongView)
        
        //        NSLayoutConstraint(item: strongView,
        //                           attribute: .top,
        //                           relatedBy: .equal,
        //                           toItem: textField,
        //                           attribute: .bottom,
        //                           multiplier: 1,
        //                           constant: 40).isActive = true
        //
        //        NSLayoutConstraint(item: strongView,
        //                           attribute: .leading,
        //                           relatedBy: .equal,
        //                           toItem: self,
        //                           attribute: .leading,
        //                           multiplier: 1,
        //                           constant: 140).isActive = true
        
        //MARK: StackView
        
        let viewsStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        addSubview(viewsStackView)
        viewsStackView.translatesAutoresizingMaskIntoConstraints = false
        
     
        viewsStackView.topAnchor.constraint(equalTo: passwordContainerView.bottomAnchor, constant: 16).isActive = true
        viewsStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        viewsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        
        viewsStackView.axis = .horizontal
        viewsStackView.alignment = .fill
        viewsStackView.distribution = .fill
        viewsStackView.spacing = 3
        
        
          //MARK:              strengthDescripton label
          
          
          strengthDescriptionLabel.text = "WEAK"
          strengthDescriptionLabel.textAlignment = .right
          strengthDescriptionLabel.textColor = labelTextColor
          strengthDescriptionLabel.font = labelFont
          addSubview(strengthDescriptionLabel)
          strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
          
         NSLayoutConstraint.activate([
                    strengthDescriptionLabel.topAnchor.constraint(equalTo: viewsStackView.bottomAnchor, constant: standardMargin),
                    strengthDescriptionLabel.leadingAnchor.constraint(equalTo: viewsStackView.trailingAnchor, constant: standardMargin),
                    strengthDescriptionLabel.centerYAnchor.constraint(equalTo: viewsStackView.centerYAnchor),
                    bottomAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor, constant: standardMargin)
                ])
    }
        
        //    MARK: ANIMATIONS
        
        
    
    func animateViews(_ strength: PasswordStrength) {
        if strength != self.defaultStrength {
            switch strength {
            case .weak:
                UIView.animate(withDuration: 0.4, animations: {
                    self.weakView.backgroundColor = self.weakColor
                    self.mediumView.backgroundColor = self.unusedColor
                    self.strongView.backgroundColor = self.unusedColor
                    self.weakView.transform = CGAffineTransform(scaleX: 1, y: 2)
                }) { completed in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.weakView.transform = .identity
                    })
                    self.strengthDescriptionLabel.text = " Strength Weak "
                }
            case .medium:
                UIView.animate(withDuration: 0.4, animations: {
                    self.weakView.backgroundColor = self.unusedColor
                    self.mediumView.backgroundColor = self.mediumColor
                    self.strongView.backgroundColor = self.unusedColor
                    self.weakView.transform = CGAffineTransform(scaleX: 1, y: 2)
                }) { completed in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.weakView.transform = .identity
                    })
                    self.strengthDescriptionLabel.text = "Strength Medium."
                }
            case .strong:
                UIView.animate(withDuration: 0.4, animations: {
                    self.weakView.backgroundColor = self.unusedColor
                    self.mediumView.backgroundColor = self.unusedColor
                    self.strongView.backgroundColor = self.strongColor
                    self.weakView.transform = CGAffineTransform(scaleX: 1, y: 2)
                }) { completed in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.weakView.transform = .identity
                    })
                    self.strengthDescriptionLabel.text = " Strong Password "
                }
                self.defaultStrength = strength
            }
        }
    }
    
    func passwordStrength(_ length: String) {
        var strength = PasswordStrength.weak
        switch length.count {
        case 0...9:
            strength = .weak
        case 10...15:
            strength = .medium
        default:
            strength = .strong
        }
        animateViews(strength)
//
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
        
    }
    
    
    @objc func showHideButtonTapped() {
        showingPassword.toggle()
        showHideButton.setImage(UIImage(named: (showingPassword) ? "eyes-open" : "eyes-closed" ), for: .normal)
        textField.isSecureTextEntry = !showingPassword
    }
    
    
}



extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength(newText)
    
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let password = textField.text,
            !password.isEmpty else { return false }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            password = text
        }
        sendActions(for: .valueChanged)
    }
    
}

enum PasswordStrength {
    case weak
    case medium
    case strong
}



