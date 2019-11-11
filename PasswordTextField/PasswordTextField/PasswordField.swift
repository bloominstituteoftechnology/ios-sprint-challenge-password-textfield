//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable
class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""

    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
//    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
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
    private var textFieldContainerView: UIView = UIView()
    
    private var strengthStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // Lay out your subviews here
        
        titleLabel.text = "Password"
        titleLabel.textColor = labelTextColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        addSubview(textFieldContainerView)
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        textFieldContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldContainerView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        textFieldContainerView.layer.backgroundColor = #colorLiteral(red: 0.9213470245, green: 0.9213470245, blue: 0.9213470245, alpha: 1)
        textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainerView.layer.borderWidth = 0.5
        textFieldContainerView.layer.cornerRadius = 5.0
        
        
        textFieldContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -8).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 46).isActive = true
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false

        showHideButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -8).isActive = true
        
        showHideButton.addTarget(self, action: #selector(hideShowButtonSet), for: .touchDown)
        
         showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
         showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .selected)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainerView.bottomAnchor, multiplier: 1.8).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 1.2).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        weakView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        mediumView.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainerView.bottomAnchor, multiplier: 1.8).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 1.2).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        mediumView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        strongView.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainerView.bottomAnchor, multiplier: 1.8).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 1.2).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        strongView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        strengthDescriptionLabel.text = "Weak"
        strengthDescriptionLabel.textColor = .darkGray
        strengthDescriptionLabel.font = UIFont(name: "Helvetica", size: 14)
        
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.leadingAnchor, constant: 68).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainerView.bottomAnchor, multiplier: 1.4).isActive = true
        strengthDescriptionLabel.widthAnchor.constraint(equalToConstant:80).isActive = true
        
        addSubview(strengthStackView)
        strengthStackView.translatesAutoresizingMaskIntoConstraints = false
        
        strengthStackView.axis = .horizontal
        strengthStackView.distribution = .equalSpacing
        strengthStackView.alignment = .center
        strengthStackView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor).isActive = true
        strengthStackView.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainerView.bottomAnchor, multiplier: 2.6).isActive = true
        
        strengthStackView.addArrangedSubview(weakView)
        strengthStackView.addArrangedSubview(mediumView)
        strengthStackView.addArrangedSubview(strongView)
        strengthStackView.addArrangedSubview(strengthDescriptionLabel)
        
    }
    
    func checkPasswordStrength(for password: String) {
        
        if password.count <= 7 {
            strengthDescriptionLabel.text = "Weak"
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = unusedColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            
            UIView.animate(withDuration: 0.8, animations:  {
                self.weakView.transform = CGAffineTransform(scaleX: 1, y: 1.2)
            }) {_ in UIView.animate(withDuration: 0.42) {
                self.weakView.transform = .identity
                }
            }
            
        } else if password.count >= 8 && password.count < 16 {
                strengthDescriptionLabel.text = "Medium"
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = mediumColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            
            UIView.animate(withDuration: 0.8, animations:  {
                self.mediumView.transform = CGAffineTransform(scaleX: 1, y: 1.2)
            }) {_ in UIView.animate(withDuration: 0.2) {
                self.mediumView.transform = .identity
                }
            }
            
        } else {
            strengthDescriptionLabel.text = "Strong"
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = mediumColor.cgColor
            strongView.layer.backgroundColor = strongColor.cgColor
            
            UIView.animate(withDuration: 0.8, animations:  {
                self.strongView.transform = CGAffineTransform(scaleX: 1, y: 1.2)
            }) {_ in UIView.animate(withDuration: 0.2) {
                self.strongView.transform = .identity
                }
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool{
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touch = touch.location(in: self)
        if self.bounds.contains(touch) {
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for :[.touchDragOutside, .valueChanged])
        }
        
        return true
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else {return}
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside, .valueChanged])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: .touchCancel)
    }

    @objc func hideShowButtonSet() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .normal)
        }
    }
}



extension PasswordField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        checkPasswordStrength(for: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          guard let text = textField.text else{ return true }
              password = text
            let pwStrength = strengthDescriptionLabel.text
        
              print("Password: \(password) and the password strength is: \(pwStrength)")
              return true
    }
}
