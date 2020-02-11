//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import Foundation
//label for password. Hidden characters
//eye view in label for isOn show password
//three strength indicators. red, orange, or green.
//transform the three strength indicators as pop up and go back into its size
//stregnth of password is lenght
///need a strength value enum (priavte)


enum PasswordStrengthIndicator: String {
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}


class PasswordField: UIControl {
    
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private var passwordStrength: PasswordStrengthIndicator = .weak
       
    
    
    //    private var stackView: UIStackView!
    
    
    private let textFieldContainerView: UIView = UIView()
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldContainerWidth: CGFloat = 100.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let textFieldBorderWidth: CGFloat = 1
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    private let isOnEyes: Bool = false
    
    
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
    
    
    //    private func configueStackView() {
    //        self.stackView = UIStackView()
    //        stackView.translatesAutoresizingMaskIntoConstraints = false
    //        addSubview(stackView)
    //
    //        stackView.axis = .horizontal
    //        stackView.distribution = .equalSpacing
    //        stackView.spacing = 2.0
    //
    //        NSLayoutConstraint.activate([
    //            stackView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 12),
    //            stackView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor),
    //            stackView.heightAnchor.constraint(equalToConstant: 12),
    //            stackView.widthAnchor.constraint(equalToConstant: 100)
    //
    //
    //        ])
    //    }
    //
    
    func setup() {
        // Lay out your subviews here
        
        //Title Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = labelTextColor
        
        titleLabel.font = labelFont
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textAlignment = .left
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        
        let titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel,
                                                         attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: self.safeAreaLayoutGuide,
                                                         attribute: .top,
                                                         multiplier: 1,
                                                         constant: standardMargin)
        
        let titleLabelTrailingConstraint = NSLayoutConstraint(item: titleLabel,
                                                              attribute: .trailing,
                                                              relatedBy: .equal,
                                                              toItem: self.safeAreaLayoutGuide,
                                                              attribute: .trailing,
                                                              multiplier: 1,
                                                              constant: -standardMargin)
        
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
            titleLabelTrailingConstraint
        ])
        
        
        
        // Container View
        addSubview(textFieldContainerView)
        
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainerView.layer.borderWidth = textFieldBorderWidth
        textFieldContainerView.layer.cornerRadius = 2
        textFieldContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        textFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Show/Hide Button
        textFieldContainerView.addSubview(showHideButton)
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 10.0).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -10.0).isActive = true
        showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor).isActive = true
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        // Password Text Field
        textFieldContainerView.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.backgroundColor = bgColor
        
        textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 10.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 10.0).isActive = true
        textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor, constant: 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 2).isActive = true
        textField.isSecureTextEntry = true
        textField.placeholder = "Click button to show password"
        textField.becomeFirstResponder()
        
        
        //
        //         configueStackView()
        //
        //        // Weak password strength view()
        //
        //    stackView.addArrangedSubview(weakView)
        //
        //
        //
        //        weakView.translatesAutoresizingMaskIntoConstraints = false
        //        weakView.layer.cornerRadius = 2
        //        weakView.layer.backgroundColor = unusedColor.cgColor
        //
        //
        //
        //        //Medium password strength view()
        //        stackView.addArrangedSubview(mediumView)
        //        mediumView.translatesAutoresizingMaskIntoConstraints = false
        //        mediumView.layer.cornerRadius = 2
        //        mediumView.layer.backgroundColor = mediumColor.cgColor
        //
        ////        strengthDescriptionLabel.text = mediumPasswordStrength.rawValue
        //
        //        //Strong password view()
        //        stackView.addArrangedSubview(strongView)
        //
        //        strongView.translatesAutoresizingMaskIntoConstraints = false
        //        strongView.layer.cornerRadius = 2
        //    strongView.layer.backgroundColor = unusedColor.cgColor
        //
        ////        strengthDescriptionLabel.text = strongPasswordStrength.rawValue
        //
        //
        //        //Response View
        //        stackView.addArrangedSubview(strengthDescriptionLabel)
        //
        //        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        //        strengthDescriptionLabel.textColor = labelTextColor
        //    strengthDescriptionLabel.layer.backgroundColor = bgColor.cgColor
        //        strengthDescriptionLabel.font = labelFont
        ////        strengthDescriptionLabel.text = strongPasswordStrength.rawValue
        //
        //
        //    print("configuredStackedview")
        
        // Weak strength indicator
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 12).isActive = true
        weakView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weakView.layer.cornerRadius = 2
        weakView.layer.backgroundColor = weakColor.cgColor
        
        // Medium strength indicator
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mediumView.layer.cornerRadius = 2
        mediumView.layer.backgroundColor = unusedColor.cgColor
        
        //Strong strength indicator
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        strongView.layer.cornerRadius = 2
        strongView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: weakView.centerYAnchor).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 6).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        strengthDescriptionLabel.text = "Too weak"
        
        backgroundColor = bgColor
        
    }
    
    
    
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        backgroundColor = bgColor
    //
    //    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    
    private func checkPasswordStrength(_ password: String) {
        let count = password.count

        switch count {
        case 1...5:
            strengthDescriptionLabel.text = PasswordStrengthIndicator.weak.rawValue
                     mediumView.layer.backgroundColor = unusedColor.cgColor
                     strongView.layer.backgroundColor = unusedColor.cgColor
                       UIView.animate(withDuration: 0.3, animations: {
                                      self.weakView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                                  }) { _ in
                                      UIView.animate(withDuration: 0.3) {
                                          self.weakView.transform = .identity
                                      }
                                  }

        case 6...12:
            strengthDescriptionLabel.text = PasswordStrengthIndicator.medium.rawValue
            strongView.layer.backgroundColor = unusedColor.cgColor
            UIView.animate(withDuration: 0.3, animations: {
                           self.mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                           self.mediumView.layer.backgroundColor = self.mediumColor.cgColor}) { _ in
                               UIView.animate(withDuration: 0.3) {
                                   self.mediumView.transform = .identity
                               }
                       }
    
        case 13...:
            strengthDescriptionLabel.text = PasswordStrengthIndicator.strong.rawValue
            UIView.animate(withDuration: 0.3, animations: {
                self.strongView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
                self.strongView.layer.backgroundColor = self.strongColor.cgColor
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.strongView.transform = .identity
                }
            }
        default:
            strengthDescriptionLabel.text = PasswordStrengthIndicator.weak.rawValue
            mediumView.layer.backgroundColor = unusedColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            
         
        }
    }
    
//    private func passwordStrengthResponseAnimation(for password: String) {
//        switch passwordStrength {
//        case .weak:
////            strengthDescriptionLabel.text = PasswordStrengthIndicator.weak.rawValue
//            mediumView.layer.backgroundColor = unusedColor.cgColor
//            strongView.layer.backgroundColor = unusedColor.cgColor
//            UIView.animate(withDuration: 0.3, animations: {
//                self.weakView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
//            }) { _ in
//                UIView.animate(withDuration: 0.3) {
//                    self.weakView.transform = .identity
//                }
//            }
//        case .medium:
////            strengthDescriptionLabel.text = PasswordStrengthIndicator.medium.rawValue
//            strongView.layer.backgroundColor = unusedColor.cgColor
//            UIView.animate(withDuration: 0.3, animations: {
//                self.mediumView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
//                self.mediumView.layer.backgroundColor = self.mediumColor.cgColor}) { _ in
//                    UIView.animate(withDuration: 0.3) {
//                        self.mediumView.transform = .identity
//                    }
//            }
//
//        case .strong:
////            strengthDescriptionLabel.text = PasswordStrengthIndicator.strong.rawValue
//            mediumView.layer.backgroundColor = mediumColor.cgColor
//            UIView.animate(withDuration: 0.3, animations: {
//                self.strongView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
//                self.strongView.layer.backgroundColor = self.strongColor.cgColor
//            }) { _ in
//                UIView.animate(withDuration: 0.3) {
//                    self.strongView.transform = .identity
//                }
//            }
//
//        }
//
//    }
    
    private func textFieldReturn(_ textField: UITextField) -> Bool {
        guard let passwordString = textField.text else { return true }
        password = passwordString
        print("Password: \(password). Strength: \(passwordStrength.rawValue)")
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func showHideButtonTapped() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry == true {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
}



extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        checkPasswordStrength(newText)
        
        return true
    }
}

extension UIView {
    
    func preformFlare() {
        func flare() { transform = CGAffineTransform(scaleX: 2, y: 3)}
        func unFlare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: {_ in UIView.animate(withDuration: 0.1) { unFlare() }})
    }
}


