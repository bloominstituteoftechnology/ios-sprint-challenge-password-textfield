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
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        titleLabel.text = "ENTER PASSWORD"

        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.becomeFirstResponder()
        textField.delegate = self

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        self.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
   
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 4),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4)
        ])
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        textField.isSecureTextEntry = true
        showHideButton.addTarget(self, action: #selector(showHideTapped(_:)), for: .touchUpInside)

        self.addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
                mediumView.backgroundColor = unusedColor

                self.addSubview(strongView)
                strongView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        ])
                strongView.backgroundColor = unusedColor

                self.addSubview(strengthDescriptionLabel)
                strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin)
        ])
                strengthDescriptionLabel.font = labelFont
                strengthDescriptionLabel.textColor = labelTextColor
                strengthDescriptionLabel.text = "Enter a Password"

        
             }

    @objc func showHideTapped(_ sender: UIButton){
                if textField.isSecureTextEntry  {
                    showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
                } else {
                    showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
                    textField.isSecureTextEntry = false
                }
            }

        
             private func checkPasswordStrength(password: String) {
                let passwordCharacters = password.count

                 switch passwordCharacters {
                case 0...9:
                    weakView.backgroundColor = weakColor
                    mediumView.backgroundColor = unusedColor
                    strongView.backgroundColor = unusedColor
                    strengthDescriptionLabel.text = "Weak Password"
                    weakView.performFlare()
                case 10...19:
                    weakView.backgroundColor = weakColor
                    mediumView.backgroundColor = mediumColor
                    strongView.backgroundColor = unusedColor
                    strengthDescriptionLabel.text = "Slightly Better Password"
                    mediumView.performFlare()
                case 20...:
                    weakView.backgroundColor = weakColor
                    mediumView.backgroundColor = mediumColor
                    strongView.backgroundColor = strongColor
                    strengthDescriptionLabel.text = "Strong Password"
                    mediumView.performFlare()
                default:
                    (print("something wrong"))
                }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
}

extension UIView {
    func performFlare() {
        func flare() { transform = CGAffineTransform(scaleX: 1.6, y: 1.6)}
        func unflare() { transform = .identity}
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() } } )
        }
    }

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        checkPasswordStrength(password: newText)
        return true
    }
}
