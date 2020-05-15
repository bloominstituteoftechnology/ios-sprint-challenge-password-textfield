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

@IBDesignable
class PasswordField: UIControl {
    
    //MARK: - PUBLIC API
    //These properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    private (set) var passwordShowing: Bool = false
    
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
    
    //MARK: - PASSWORD EYE OPEN/CLOSE
    private func changeShowHideButton() {
        switch textField.isSecureTextEntry {
        case true:
            showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        default:
            showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .normal)
        }
    }
    
    //MARK: - SUBVIEWS
    func setup() {
        
        //MARK: - TITLE LABEL
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //TITLE LABEL CHARACTERISTICS
        titleLabel.text = "Enter Password Here"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        //CONSTRAINTS
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        //MARK: - TEXTFIELD
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.isUserInteractionEnabled = true
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.delegate = self
        //CONSTRAINTS
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        //MARK: - TEXTFIELD EYE BUTTON
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        showHideButton.addTarget(self, action: #selector(changeEyeButtonImage), for: [.touchDragInside, .valueChanged])
        
        //MARK: - WEAK VIEW
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = 3
        weakView.backgroundColor = weakColor
        //WEAK CONSTRAINTS
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        //MARK: - MEDIUM VIEW
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = 3
        mediumView.backgroundColor = unusedColor
        //MEDIUM CONSTRAINTS
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        //MARK: - STRONG VIEW
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = 3
        strongView.backgroundColor = unusedColor
        //STRONG CONSTRAINTS
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        //MARK: - DESCRIPTION CONSTRAINTS
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        //DESCRIPTION CHARACTERISTICS
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.font = labelFont
        //DESCRIPTION CONSTRAINTS
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        changeEyeButtonImage()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @objc func changeEyeButtonImage() {
        changeShowHideButton()
    }
    
    //MARK: - STRENGTH INDICATORS
    private func updatePasswordStrength(strength: PasswordStrength) {
        switch strength {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too weak"
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Make stronger"
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        }
    }
    
    //MARK: - PASSWORD STRENGTH COUNT
    private func passwordStrength(password: String) {
        switch password.count {
        case 0...5:
            updatePasswordStrength(strength: .weak)
        case 6...9:
            updatePasswordStrength(strength: .medium)
        case 9...99:
            updatePasswordStrength(strength: .strong)
        default:
            updatePasswordStrength(strength: .weak)
        }
    }
}
//MARK: - CLASS EXTENSION
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        passwordStrength(password: newText)
        return true
    }
}
