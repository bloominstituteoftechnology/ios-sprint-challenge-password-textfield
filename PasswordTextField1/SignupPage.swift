//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//


import UIKit

class SignupPage: UIControl, UITextFieldDelegate {
    
    
    enum StrengthType: String {
        case weak = "Too Weak"
        case medium = "Could be stronger"
        case strong = "Strong Password"
    }
    
    // MARK: - Properties
    
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
    
    private let backgroundImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let textFieldContainer: UIView = UIView()
    private var textField: UITextField = UITextField()
    private let passwordStrengthLabel: UILabel = UILabel()
    private let colorContainerView: UIView = UIView()
    private let stackView: UIStackView = UIStackView()
    private let weakView : UIView = UIView()
    private let mediumView : UIView = UIView()
    private let strongView : UIView = UIView()
    private let showHideButton: UIButton = UIButton()
    private let button: UIButton = UIButton()
    
    
    // MARK: - Required Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubViews()
        textField.delegate = self
        
    }
    
    // MARK: - Methods and Functions
    
    func setupSubViews() {
        
        // password label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        
        // password container view
        addSubview(textFieldContainer)
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldContainer.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        textFieldContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldContainer.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainer.layer.borderWidth = 2
        textFieldContainer.layer.cornerRadius = 5
        
        // password text field
        textFieldContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: 8).isActive = true
        textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 8).isActive = true
        textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -8).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -8).isActive = true
        textField.placeholder = "Password"
        
        textFieldContainer.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: 12).isActive = true
        button.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -8).isActive = true
        button.setImage(#imageLiteral(resourceName: "eyes-open"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(eyeOpen), for: .touchUpInside)
        
        
        
        // Password label
        addSubview(passwordStrengthLabel)
        passwordStrengthLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordStrengthLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordStrengthLabel.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainer.bottomAnchor, multiplier: 1).isActive = true
        passwordStrengthLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordStrengthLabel.text = "Password strength"
        passwordStrengthLabel.font = labelFont
        
        // Color container view
        addSubview(colorContainerView)
        colorContainerView.translatesAutoresizingMaskIntoConstraints = false
        colorContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        colorContainerView.topAnchor.constraint(equalToSystemSpacingBelow: passwordStrengthLabel.bottomAnchor, multiplier: 1.0).isActive = true
        colorContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        colorContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        colorContainerView.layer.borderColor = UIColor.clear.cgColor
        colorContainerView.layer.borderWidth = 2
        colorContainerView.layer.cornerRadius = 5
        
        
        colorContainerView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: colorContainerView.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: colorContainerView.trailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: colorContainerView.topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: colorContainerView.bottomAnchor, constant: 8).isActive = true
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.frame = weakView.frame.offsetBy(dx: 10, dy: 0)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.frame.size = CGSize(width: 60.0, height: 5.0)
        weakView.layer.backgroundColor = weakColor.cgColor
        
        mediumView.frame = mediumView.frame.offsetBy(dx: 75, dy: 0)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.frame.size = CGSize(width: 60.0, height: 5.0)
        mediumView.layer.backgroundColor = unusedColor.cgColor
        
        strongView.frame = mediumView.frame.offsetBy(dx: mediumView.bounds.maxX + 7, dy: 0)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.frame.size = CGSize(width: 60.0, height: 5.0)
        strongView.layer.backgroundColor = unusedColor.cgColor
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        
        stackView.addSubview(weakView)
        stackView.addSubview(mediumView)
        stackView.addSubview(strongView)
    }
    
    @objc func eyeOpen() {
        
        if textField.isSecureTextEntry == false {
            showHideButton.setImage(#imageLiteral(resourceName: "eyes-open"), for: .normal)
            
        }
        else {
            showHideButton.setImage(#imageLiteral(resourceName: "eyes-closed"), for: .normal)
        }
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    
    
    //text field delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.isSecureTextEntry = true
        let oldText = textField.text! //assigning old text to constant
        let stringRange = Range(range, in: oldText)! //assigning the range of old text i.e. all characters
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.count >= 5 && newText.count <= 6 {
            
            
            mediumView.transform = CGAffineTransform(scaleX: 0.1, y: 0.0)
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
                self.mediumView.backgroundColor = self.mediumColor
                self.mediumView.transform = .identity
            }, completion: nil)
            
            
            strongView.backgroundColor = unusedColor
            weakView.backgroundColor = weakColor
            
            
            passwordStrengthLabel.text = StrengthType.medium.rawValue
            passwordStrengthLabel.font = labelFont
        }
        else if newText.count >= 7  {
            
            strongView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                self.strongView.backgroundColor = self.strongColor
                self.strongView.transform = .identity
            }, completion: nil)
            
            
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
            
            passwordStrengthLabel.text = StrengthType.strong.rawValue
            passwordStrengthLabel.font = labelFont
            
        }
        else {
            strongView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            weakView.backgroundColor = weakColor
            
            passwordStrengthLabel.text = StrengthType.weak.rawValue
            passwordStrengthLabel.font = labelFont
            
        }
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.password = textField.text!
        sendActions(for: .valueChanged)
        
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField = textField
    }
    
}
