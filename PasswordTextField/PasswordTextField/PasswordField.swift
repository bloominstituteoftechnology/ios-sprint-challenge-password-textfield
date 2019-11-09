//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
enum PasswordRating: String {
    case empty = ""
    case weak = "Too Weak"
    case decent = "Could Be Stronger"
    case impenetrable = "Strong Password"
}

class PasswordField: UIControl {
    
    private (set) var password: String = PasswordRating.empty.rawValue
    private var weakBarLit = false
    private var mediumBarLit = false
    private var strongBarLit = false
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let viewCornerRadius: CGFloat = 1.0
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    private let strengthDescriptionFont = UIFont.systemFont(ofSize: 14.0, weight: .medium)
    
    private let bgColor = UIColor.white
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    private var textFieldBorderColor = UIColor.gray
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.delegate = self
        setup()
    }
    
    
    func setup() {
        
        backgroundColor = bgColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        textField.placeholder = "Enter your password"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.isSecureTextEntry = true
        
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(passwordVisibility), for: .touchUpInside)
        
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.layer.cornerRadius = viewCornerRadius
        weakView.backgroundColor = unusedColor
        
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.layer.cornerRadius = viewCornerRadius
        mediumView.backgroundColor = unusedColor
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.layer.cornerRadius = viewCornerRadius
        strongView.backgroundColor = unusedColor
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.font = strengthDescriptionFont
        strengthDescriptionLabel.text = PasswordRating.empty.rawValue
        
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: standardMargin),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -standardMargin),
            showHideButton.widthAnchor.constraint(equalToConstant: 40),
            
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            weakView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            
            
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 3),
            mediumView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            mediumView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            
            strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 3),
            strongView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            strongView.widthAnchor.constraint(equalToConstant: frame.size.width / 10),
            strongView.heightAnchor.constraint(equalToConstant: standardMargin / 2),
            
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
    }
    
    
    @objc func passwordVisibility() {
        
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry == false {
            UIView.animate(withDuration: 0.3) {
                self.showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            }
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    
    func passwordCheck(password: String) {
        
        switch password.count {
            
        case 0...9:
            strengthDescriptionLabel.text = PasswordRating.weak.rawValue
            if weakBarLit == false {
                strongView.backgroundColor = unusedColor
                mediumView.backgroundColor = unusedColor
                UIView.animate(withDuration: 0.3) {
                    self.textField.tintColor = self.weakColor
                    self.textField.layer.borderColor = self.weakColor.cgColor
                    self.weakView.backgroundColor = self.weakColor
                    self.weakView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.weakColor
                },
                                  completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.weakView.transform = .identity
                }, completion: nil)
                weakBarLit = true
            }
            
            if mediumBarLit == true {
                UIView.animate(withDuration: 0.3) {
                    self.textField.tintColor = self.weakColor
                    self.mediumView.backgroundColor = self.unusedColor
                    self.textField.layer.borderColor = self.weakColor.cgColor
                    self.mediumView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.weakColor
                },
                                  completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.mediumView.transform = .identity
                }, completion: nil)
                mediumBarLit = false
                strongBarLit = false
            }
            
        case 10...19:
            strengthDescriptionLabel.text = PasswordRating.decent.rawValue
            strengthDescriptionLabel.textColor = mediumColor
            
            if mediumBarLit == false {
                strongView.backgroundColor = unusedColor
                UIView.animate(withDuration: 0.3) {
                    self.textField.layer.borderColor = self.mediumColor.cgColor
                    self.textField.tintColor = self.mediumColor
                    self.mediumView.backgroundColor = self.mediumColor
                    self.mediumView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.mediumColor
                },
                                  completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.mediumView.transform = .identity
                }, completion: nil)
                mediumBarLit = true
            }
            
            if strongBarLit == true {
                UIView.animate(withDuration: 0.3) {
                    self.textField.layer.borderColor = self.mediumColor.cgColor
                    self.textField.tintColor = self.mediumColor
                    self.strongView.backgroundColor = self.unusedColor
                    self.strongView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.mediumColor
                },
                                  completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.strongView.transform = .identity
                }, completion: nil)
                strongBarLit = false
            }
        default:
            strengthDescriptionLabel.text = PasswordRating.impenetrable.rawValue
            strengthDescriptionLabel.textColor = strongColor
            if strongBarLit == false {
                UIView.animate(withDuration: 0.3) {
                    self.textField.layer.borderColor = self.strongColor.cgColor
                    self.textField.tintColor = self.strongColor
                    self.strongView.backgroundColor = self.strongColor
                    self.strongView.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
                }
                UIView.transition(with: strengthDescriptionLabel, duration: 0.25, options: .transitionCrossDissolve, animations: {
                    self.strengthDescriptionLabel.textColor = self.strongColor
                },
                                  completion: nil)
                UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
                    self.strongView.transform = .identity
                }, completion: nil)
                strongBarLit = true
            }
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordCheck(password: newText)
        password = newText
        return true
    }
}
