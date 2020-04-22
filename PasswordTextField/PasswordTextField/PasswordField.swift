//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "Weak Password"
    case medium = "Medium Password"
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
    
    func setup() {
        // Lay out your subviews here
        
        self.backgroundColor = .lightGray
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
            titleLabel.textColor = labelTextColor
            titleLabel.font = labelFont

            NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: standardMargin), titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: standardMargin), titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: standardMargin)])

            addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.layer.borderWidth = 2
            textField.layer.borderColor = textFieldBorderColor.cgColor
            textField.backgroundColor = bgColor
            textField.borderStyle = .roundedRect
            textField.isSecureTextEntry = true

            NSLayoutConstraint.activate([textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin), textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -textFieldMargin), textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin), textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)])

            addSubview(showHideButton)
            showHideButton.frame = CGRect(x: 330, y: 44, width: 30, height: 30)
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            showHideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)


            addSubview(weakView)
            weakView.backgroundColor = weakColor
            weakView.frame = CGRect(x: standardMargin, y: 97, width: colorViewSize.width, height: colorViewSize.height)

            addSubview(mediumView)
            mediumView.backgroundColor = unusedColor
            mediumView.frame = CGRect(x: standardMargin * 2 + colorViewSize.width, y: 97, width: colorViewSize.width, height: colorViewSize.height)

            addSubview(strongView)
            strongView.backgroundColor = unusedColor
            strongView.frame = CGRect(x: standardMargin * 3 + colorViewSize.width * 2, y: 97, width: colorViewSize.width, height: colorViewSize.height)

            addSubview(strengthDescriptionLabel)
            strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            strengthDescriptionLabel.text = "Too Weak"
            strengthDescriptionLabel.textColor = labelTextColor
            strengthDescriptionLabel.font = labelFont

            NSLayoutConstraint.activate([strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin), strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin), strengthDescriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin)])
        }

        @objc func buttonTapped() {
            if showHideButton.currentImage!.isEqual(UIImage(named: "eyes-closed")) {
                textField.isSecureTextEntry = false
                showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            } else {
                textField.isSecureTextEntry = true
                showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        
        self.password = newText

            let myX: CGFloat = 1.2
            let myY: CGFloat = 1.6

            switch newText.count {
                case 1:
                    weakView.backgroundColor      = weakColor
                    mediumView.backgroundColor    = unusedColor
                    strongView.backgroundColor    = unusedColor
                    strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
                    weakView.transform = CGAffineTransform(scaleX: myX, y: myY)
                    UIView.animate(withDuration: 0.5) {
                        self.weakView.transform = .identity
                    }
                case 2...9:
                    weakView.backgroundColor      = weakColor
                    mediumView.backgroundColor    = unusedColor
                    strongView.backgroundColor    = unusedColor
                    strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
                case 10:
                    weakView.backgroundColor      = weakColor
                    mediumView.backgroundColor    = mediumColor
                    strongView.backgroundColor    = unusedColor
                    strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
                    mediumView.transform = CGAffineTransform(scaleX: myX, y: myY)
                    UIView.animate(withDuration: 0.5) {
                        self.mediumView.transform = .identity
                    }
                case 11...19:
                    weakView.backgroundColor      = weakColor
                    mediumView.backgroundColor    = mediumColor
                    strongView.backgroundColor    = unusedColor
                    strengthDescriptionLabel.text = PasswordStrength.medium.rawValue
                case 20:
                    weakView.backgroundColor      = weakColor
                    mediumView.backgroundColor    = mediumColor
                    strongView.backgroundColor    = strongColor
                    strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
                    strongView.transform = CGAffineTransform(scaleX: myX, y: myY)
                    UIView.animate(withDuration: 0.5) {
                        self.strongView.transform = .identity
                    }
                case 21...Int.max:
                    weakView.backgroundColor      = weakColor
                    mediumView.backgroundColor    = mediumColor
                    strongView.backgroundColor    = strongColor
                    strengthDescriptionLabel.text = PasswordStrength.strong.rawValue
                default:
                    weakView.backgroundColor   = weakColor
                    mediumView.backgroundColor = unusedColor
                    strongView.backgroundColor = unusedColor
            }

            return true
        }

        func resetControl() {
            weakView.backgroundColor   = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            sendActions(for: .valueChanged)
            resetControl()
            textField.text = ""
            return true
    }
}
