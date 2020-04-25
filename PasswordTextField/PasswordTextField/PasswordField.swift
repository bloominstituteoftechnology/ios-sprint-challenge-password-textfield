//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.


import UIKit

enum Strength: String {
    case none = ""
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = "" //
    private (set) var strength: Strength = .none
    
    private let standardMargin: CGFloat = 8.0 //
    private let textFieldContainerHeight: CGFloat = 50.0 //
    private let textFieldMargin: CGFloat = 6.0 //
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0) //
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)  //
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold) //
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1) //
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1) //
    
    // States of the password strength indicators //
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1) //
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1) //
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1) //
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1) //
    
    private var titleLabel: UILabel = UILabel() //
    private var textField: UITextField = UITextField() //
    private var showHideButton: UIButton = UIButton() //
    private var weakView: UIView = UIView() //
    private var mediumView: UIView = UIView() //
    private var strongView: UIView = UIView() //
    private var strengthDescriptionLabel: UILabel = UILabel() //
    
    func setup() { //
        
        textField.delegate = self
        self.backgroundColor = bgColor
        
        addSubview(titleLabel) //
        titleLabel.translatesAutoresizingMaskIntoConstraints = false //
        titleLabel.text = "Enter password"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter password"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.isSecureTextEntry = true // Should this be here or somewhere else with the eye image?
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed") , for: .normal)
        showHideButton.addTarget(self, action: #selector(passwordVisible), for: .touchUpInside)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = unusedColor
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = unusedColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = unusedColor
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false 
        
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            mediumView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),

            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin),
            strongView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) { //
        super.init(coder: aDecoder) //
        setup() //
    }
    
    @objc func passwordVisible() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry == true {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    func strenghAnalyzer(passwordCount: Int) {
        switch passwordCount {
        case 0:
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = Strength.none.rawValue
            strength = .none
        case 1:
            strengthDescriptionLabel.text = Strength.weak.rawValue
            strength = .weak
            weakView.performFlare()
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 2...8:
            strengthDescriptionLabel.text = Strength.weak.rawValue
            strength = .weak
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 9:
            strengthDescriptionLabel.text = Strength.weak.rawValue
            strength = .weak
            weakView.performFlare()
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 10:
            strengthDescriptionLabel.text = Strength.medium.rawValue
            strength = .medium
            mediumView.performFlare()
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case 11...18:
            strengthDescriptionLabel.text = Strength.medium.rawValue
            strength = .medium
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case 19:
            strengthDescriptionLabel.text = Strength.medium.rawValue
            strength = .medium
            mediumView.performFlare()
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case 20:
            strengthDescriptionLabel.text = Strength.strong.rawValue
            strength = .strong
            strongView.performFlare()
            strongView.backgroundColor = strongColor
        case 21...passwordCount:
            strengthDescriptionLabel.text = Strength.strong.rawValue
            strength = .strong
            strongView.backgroundColor = strongColor
        default:
            strengthDescriptionLabel.text = Strength.none.rawValue
            strength = .none
        }
    }
    
}

extension PasswordField: UITextFieldDelegate { //
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { //
        let oldText = textField.text! //
        let stringRange = Range(range, in: oldText)! //
        let newText = oldText.replacingCharacters(in: stringRange, with: string) //
        strenghAnalyzer(passwordCount: newText.count)
        return true //
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else { return false }
        password = text
        strenghAnalyzer(passwordCount: password.count)
        sendActions(for: .valueChanged)
        return false
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let text = textField.text else { return }
//        password = text
//        sendActions(for: .valueChanged)
//    }
}

extension UIView {
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.0, y: 1.5) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.25,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
