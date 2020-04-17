//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    //MARK: - Properties
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldContainerView: UIView = UIView()
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private var closedEyeImage: UIImage = UIImage(named: "eyes-closed")!
    private var openEyeImage: UIImage = UIImage(named: "eyes-open")!
    
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
    private var buttonWasTapped: Bool = false
    
    enum passWordStrength: String {
        case weak = "too weak"
        case medium = "could be stronger"
        case strong = "strong password"
        
    }
    
    private var characterCount: Int?
    
    // MARK: - Required Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    // MARK: - Methods
    
    func setup() {
        
        backgroundColor = bgColor
        
        // container view
        addSubview(textFieldContainerView)
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textFieldContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textFieldContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        // title label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -20).isActive = true
        titleLabel.text = "Enter password"
        titleLabel.textColor = labelTextColor
        
        // Password Text Field
        textFieldContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 6).isActive = true
        textField.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -textFieldMargin).isActive = true
        textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -6).isActive = true
        textField.placeholder = "   Password"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.cornerRadius = 8.0
        textField.isSecureTextEntry = true
        
        // login button
        textFieldContainerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalToSystemSpacingBelow: textFieldContainerView.topAnchor, multiplier: 1.5).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -12).isActive = true
        showHideButton.setImage(closedEyeImage, for: .normal)
        showHideButton.setTitleColor(.black, for: .normal)
        
        showHideButton.addTarget(self, action: #selector(myButtonTapped), for:  UIControl.Event.touchUpInside)
        
        // strength description label
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -6).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -8).isActive = true
        //        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor).isActive = true
        
        strengthDescriptionLabel.text = ""
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
        // weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: 8).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        weakView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 0).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        weakView.backgroundColor = .white
        weakView.layer.cornerRadius = 12.0
        
        // medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalToSystemSpacingAfter: weakView.trailingAnchor, multiplier: 0.5).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mediumView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 0).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        mediumView.backgroundColor = .white
        mediumView.layer.cornerRadius = 8.0
        
        // strong view
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 4).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        strongView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 0).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 6).isActive = true
        strongView.backgroundColor = .white
        strongView.layer.cornerRadius = 8.0
        
    }
    
    func updateStrengthIndicator() {
        guard let characterCount = characterCount else { return }
        switch characterCount {
        case 1...9:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = .white
            strongView.backgroundColor = .white
            strengthDescriptionLabel.text = passWordStrength.weak.rawValue
        case 10...19:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = .white
            strengthDescriptionLabel.text = passWordStrength.medium.rawValue
            
        case 20...1000:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = passWordStrength.strong.rawValue
            
        default:
            weakView.backgroundColor = .white
            mediumView.backgroundColor = .white
            strongView.backgroundColor = .white
            strengthDescriptionLabel.text = ""
        }
    }
    
    func returnPassword() {
        guard let textField = textField.text,
            let strengthDescriptionLabel = strengthDescriptionLabel.text
            else { return }
        password = textField
        print("Password: \(password)")
        print("Strength: \(strengthDescriptionLabel)")
        
    }
}

    // MARK: - Extensions

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        characterCount = textField.text?.count
        updateStrengthIndicator()
//        myButtonTapped()
        
        return newText.count <= 26
    }
    
    @objc func myButtonTapped() {
        buttonWasTapped.toggle()
        print(buttonWasTapped)
        
        if buttonWasTapped == true {
            showHideButton.setImage(openEyeImage, for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(closedEyeImage, for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Text field should begin editing")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool  {
        textField.resignFirstResponder()
        returnPassword()
        return true
    }
    
}



