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
    
    enum Strength: String {
        case weak
        case medium
        case strong
    }
    
    func setup() {
        textField.delegate = self
        
        backgroundColor = bgColor
        
        // Lay out your subviews here
        
        // ENTER PASSWORD LABEL
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textAlignment = .left
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
            // constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: standardMargin)
        ])
        
        // TEXTFIELD
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 3.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.isSecureTextEntry = true
        
        
        

        
            // constraints
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // SHOW BUTTON
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.frame = CGRect(x: 10, y: -100, width: 40, height: 40)
        if let image = UIImage(named: "eyes-closed") {
            showHideButton.setBackgroundImage(image, for: .normal)
        }
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped(_:)), for: .touchUpInside)
        
            // constraints
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: standardMargin * 2),
            showHideButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // WEAK VIEW
        
        
//        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.frame = CGRect(x: 0, y: 0, width: colorViewSize.width, height: 1)
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = 5
        
        
        // MEDIUM VIEW
        
//        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.frame = CGRect(x: 0, y: 0, width: colorViewSize.width, height: 1)
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = 5
        
        
        // STRONG VIEW
        
//        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.frame = CGRect(x: 0, y: 0, width: colorViewSize.width, height: 1)
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = 5
        
        // STRENGTH LABEL
        
        addSubview(strengthDescriptionLabel)

        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -standardMargin)
        ])
        
        
        
        // STACKVIEW AND CONSTRAINTS
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)

        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -standardMargin),
            stackView.trailingAnchor.constraint(equalTo: strengthDescriptionLabel.leadingAnchor, constant: standardMargin),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

        ])
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @ objc func showHideButtonTapped(_: UIButton) {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry == true {
            showHideButton.setBackgroundImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setBackgroundImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    func viewSpring(_ barView: UIView) {
        print("working")

        barView.transform = CGAffineTransform(scaleX: 1.0, y: 1.2)
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            barView.transform = .identity
        }, completion: nil)
    }
    

    func passwordCheck() {
        
        print("password check: \(password)")
        var pwStrength: Strength
        
        switch password.count {
        
        case 0...3:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too weak"
            viewSpring(weakView)
            pwStrength = .weak
            
        case 4...6:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could be stronger"
            viewSpring(mediumView)
            pwStrength = .medium
            
        case 6...100:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
            viewSpring(strongView)
            pwStrength = .strong
            
        default:
            break
        
    }

}
    
    func keyBoardDismiss(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method

        password = newText
        passwordCheck()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendActions(for: .valueChanged)
        return true
    }

}

