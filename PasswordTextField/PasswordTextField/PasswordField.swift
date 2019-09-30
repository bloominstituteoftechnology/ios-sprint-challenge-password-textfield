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
    private let colorViewSize: CGSize = CGSize(width: 65.0, height: 10.0)
    
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
    private var confirmPassTextField: UITextField = UITextField()

    @objc private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var hidebuttonImage: UIImage = UIImage()
    
    func setup() {
        // Lay out your subviews here
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .left
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        addSubview(textField)
        textField.isSecureTextEntry = true
        textField.isEnabled = true
        textField.becomeFirstResponder()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        textField.backgroundColor = bgColor
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)

        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        let passStrength: UIStackView = UIStackView()
        passStrength.translatesAutoresizingMaskIntoConstraints = false
        passStrength.axis = .horizontal
        passStrength.distribution = .fill
        passStrength.alignment = .fill
        passStrength.spacing = standardMargin
        addSubview(passStrength)
        
        passStrength.addArrangedSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = 4
        weakView.clipsToBounds = true
        weakView.backgroundColor = unusedColor
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        passStrength.addArrangedSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = 4
        mediumView.clipsToBounds = true
        mediumView.backgroundColor = unusedColor
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        passStrength.addArrangedSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = 4
        strongView.clipsToBounds = true
        strongView.backgroundColor = unusedColor
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        passStrength.addArrangedSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.textAlignment = .left
        strengthDescriptionLabel.textColor = .black
        strengthDescriptionLabel.text = ""
        strengthDescriptionLabel.font = .boldSystemFont(ofSize: 9)
        strengthDescriptionLabel.allowsDefaultTighteningForTruncation = true
        strengthDescriptionLabel.adjustsFontSizeToFitWidth = true
        strengthDescriptionLabel.minimumScaleFactor = 0.9
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 5).isActive = true
        
        
        passStrength.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        passStrength.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        passStrength.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(getter: showHideButton), for: .touchUpInside)
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 15).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -15).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -15)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textField.delegate = self
        setup()
    }
    
    @objc func showPassword() {
        textField.isSecureTextEntry.toggle()
        
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    
    func checkPasswordLength(_ password: String) {
        let passCount = password.count
        
        switch passCount {
        case 0:
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 1...9:
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Too Weak"
        case 10...19:
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could be Stronger"
        default:
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong Password"
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        self.password = newText
        self.checkPasswordLength(newText)
        return true
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
