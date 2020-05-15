//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Enzo Jimenez-Soto on 5/19/20.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import Foundation

enum Strength {
    case strong
    case medium
    case weak
}

class PasswordField: UIControl {
    
    
    private (set) var password: String = ""
    private (set) var passwordStrength: Strength = .weak
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
   
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
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func setup() {

        backgroundColor = .clear
        congfigureLabel()
        configureTextField()
        configureViews()
    }
    
    func congfigureLabel() {
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
    }
    
    func configureTextField() {
        
        textField.borderStyle = .roundedRect
        textField.backgroundColor = bgColor
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = standardMargin
        textField.clipsToBounds = true
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2.0 * standardMargin, bottom: 0, right: 0)
        showHideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    func configureViews() {
    
        weakView.backgroundColor = weakColor
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2.0).isActive = true
        weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.layer.cornerRadius = 2.0
        
        
        mediumView.backgroundColor = unusedColor
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2.0).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: textFieldMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.layer.cornerRadius = 2.0
        
    
        strongView.backgroundColor = unusedColor
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2.0).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: textFieldMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.layer.cornerRadius = 2.0
        

        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor).isActive = true
        
    }
    
    @objc func buttonTapped() {
        showHideButton.isSelected.toggle()
        if showHideButton.isSelected {
    
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        }
        else {
        
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    func checkStrength(pw: String?) {
        
        guard let pw = pw else {return}
        password = pw
        
        if pw.count >= 20 {
            passwordStrength = .strong
            strongView.backgroundColor = strongColor
            if pw.count == 20 { strongView.performFlare() }
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Strong password"
        }
        else if pw.count <= 19 && pw.count >= 10 {
            passwordStrength = .medium
            strongView.backgroundColor = unusedColor
            mediumView.backgroundColor = mediumColor
            if pw.count == 10 { mediumView.performFlare() }
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Could be stronger"
        }
        else {
            passwordStrength = .weak
            strongView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Too weak"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkStrength(pw: textField.text)
        sendActions(for: [.valueChanged])
        textField.resignFirstResponder()
        return true
    }
    
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        checkStrength(pw: newText)
        return true
    }
}

extension UIView {
   
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.1, y: 1.5) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.2,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}


