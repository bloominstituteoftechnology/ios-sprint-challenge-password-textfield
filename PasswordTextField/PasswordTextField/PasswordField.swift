//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // MARK: - Properties
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
    private var showHideButton: UIButton = UIButton(type: .system)
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var privateIsSelected: Bool = false
    
    
    // MARK: - Actions
    
    @objc func visiblePasswordToggled(_ sender: UIButton){
        if !privateIsSelected {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            privateIsSelected = !privateIsSelected
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            privateIsSelected = !privateIsSelected
        }
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text)
        print(strengthDescriptionLabel.text)
        return true
    }
    
    // MARK: - View Lifecycle
    
    
    func setup() {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 10.0
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            self.heightAnchor.constraint(equalToConstant: 120.0)
        ])
        textField.delegate = self
        
        titleLabel.text = "EnterPassword"
        addSubview(titleLabel)
        
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1
        textField.isUserInteractionEnabled = true
        textField.isSecureTextEntry = true
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        textField.addTarget(self,
                            action: #selector(textFieldShouldReturn(_:)),
                            for: .editingDidEnd)
        addSubview(textField.rightView!)
        addSubview(textField)
        
        showHideButton.isEnabled = true
        showHideButton.tintColor = .gray
        showHideButton.setImage(UIImage(named: "eyes-closed"),
                                for: .normal)
        showHideButton.addTarget(self,
                                 action: #selector(self.visiblePasswordToggled(_:)),
                                 for: .touchUpInside)
        addSubview(showHideButton)
        
        weakView.backgroundColor = unusedColor
        addSubview(weakView)
        
        mediumView.backgroundColor = unusedColor
        addSubview(mediumView)
        
        strongView.backgroundColor = unusedColor
        addSubview(strongView)
        
        strengthDescriptionLabel.text = ""
        addSubview(strengthDescriptionLabel)
    }
    
    func setupConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                        constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                            constant: standardMargin).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                           constant: standardMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true

        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                      constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                          constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                        constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor,
                                            constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                        constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor,
                                            constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,
                                                      constant: 6).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor,
                                                          constant: standardMargin).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupConstraints()
    }
    
    // MARK: - Animations
    
    func determineStrength(ofPassword: String){
        let scaleXConstant = CGFloat(1.02)
        let scaleYContstant = CGFloat(1.07)
        let animationTime = TimeInterval(0.75)
        let delayTime = TimeInterval(0.75)
        
        if ofPassword.count < 1 {
            let imageBlock = {
                self.weakView.backgroundColor = self.unusedColor
                self.mediumView.backgroundColor = self.unusedColor
                self.strongView.backgroundColor = self.unusedColor
                self.strengthDescriptionLabel.text = ""
            }
            UIView.animateKeyframes(withDuration: 0.5,
                                    delay: 0,
                                    options: [],
                                    animations: imageBlock,
                                    completion: nil)
        } else if ofPassword.count < 10 {
            let imageBlock = {
                self.weakView.backgroundColor = self.weakColor
                self.weakView.transform = CGAffineTransform(scaleX: scaleXConstant,
                                                            y: scaleYContstant)
                self.strengthDescriptionLabel.text = "too weak"
                self.mediumView.backgroundColor = self.unusedColor
                self.strongView.backgroundColor = self.unusedColor
            }
            let sizeResest = {
                self.weakView.transform = .identity
            }
            UIView.animateKeyframes(withDuration: animationTime,
                                    delay: 0,
                                    options: [],
                                    animations: imageBlock,
                                    completion: nil)
            UIView.animateKeyframes(withDuration: animationTime,
                                    delay: delayTime,
                                    options: [],
                                    animations: sizeResest,
                                    completion: nil)
            
        } else if ofPassword.count >= 10 && ofPassword.count < 19 {
            let imageBlock = {
                self.mediumView.backgroundColor = self.mediumColor
                self.mediumView.transform = CGAffineTransform(scaleX: scaleXConstant,
                                                              y: scaleYContstant)
                self.strengthDescriptionLabel.text = "could be better"
                self.strongView.backgroundColor = self.unusedColor
            }
            let sizeResest = {
                self.mediumView.transform = .identity
            }
            UIView.animateKeyframes(withDuration: animationTime,
                                    delay: 0,
                                    options: [],
                                    animations: imageBlock,
                                    completion: nil)
            UIView.animateKeyframes(withDuration: animationTime,
                                    delay: delayTime,
                                    options: [],
                                    animations: sizeResest,
                                    completion: nil)
        } else if ofPassword.count >= 20 {
            let imageBlock = {
                self.strongView.backgroundColor = self.strongColor
                self.strongView.transform = CGAffineTransform(scaleX: scaleXConstant,
                                                              y: scaleYContstant)
                self.strengthDescriptionLabel.text = "strong password"
            }
            let sizeResest = {
                self.mediumView.transform = .identity
            }
            UIView.animateKeyframes(withDuration: animationTime,
                                    delay: 0,
                                    options: [],
                                    animations: imageBlock,
                                    completion: nil)
            UIView.animateKeyframes(withDuration: animationTime,
                                    delay: delayTime,
                                    options: [],
                                    animations: sizeResest,
                                    completion: nil)
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        determineStrength(ofPassword: newText)
        return true
    }
}
