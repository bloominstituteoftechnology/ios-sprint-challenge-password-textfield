//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//
import Foundation
import UIKit
enum passStrength: String {
    case weak = "Too Weak"
    case medium = "Can be Stronger"
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
    private var txtFieldContainerView = UIView()
    private var showHideButton: UIButton = UIButton(type: .system)
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
   
    
    func setup() {
        // Lay out your subviews here
        backgroundColor = bgColor

//        //title label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 110 + standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        
        //password ContainerView
        addSubview(txtFieldContainerView)
        txtFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        txtFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        txtFieldContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        trailingAnchor.constraint(equalTo: txtFieldContainerView.trailingAnchor, constant: standardMargin).isActive = true
        txtFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        txtFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
        txtFieldContainerView.layer.borderWidth = 2.0
        txtFieldContainerView.layer.cornerRadius = 5.0
        
        //textfield for password
        txtFieldContainerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: txtFieldContainerView.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: txtFieldContainerView.topAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: txtFieldContainerView.trailingAnchor).isActive = true
        txtFieldContainerView.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        textField.placeholder = "Password"
        textField.delegate = self
        textField.isSecureTextEntry = true
        
        
        //setup button
        textField.addSubview(showHideButton)
        textField.rightViewMode = .always
        textField.rightView = showHideButton
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.isEnabled = true
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHidePasswordToggle), for: .touchUpInside)
        
        
        //setup strength bars
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = unusedColor
        weakView.leadingAnchor.constraint(equalTo: txtFieldContainerView.leadingAnchor).isActive = true
        weakView.topAnchor.constraint(equalTo: txtFieldContainerView.bottomAnchor, constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        weakView.layer.cornerRadius = 2
        
        addSubview(mediumView)
        mediumView.backgroundColor = unusedColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2).isActive = true
        mediumView.topAnchor.constraint(equalTo: txtFieldContainerView.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        mediumView.layer.cornerRadius = 2
        
        addSubview(strongView)
        strongView.backgroundColor = unusedColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2).isActive = true
        strongView.topAnchor.constraint(equalTo: txtFieldContainerView.bottomAnchor, constant:  standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        strongView.layer.cornerRadius = 2
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = ""
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        
        strengthDescriptionLabel.topAnchor.constraint(equalTo: txtFieldContainerView.bottomAnchor, constant: standardMargin).isActive = true
        
//        let strengthBarsStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView, strengthDescriptionLabel])
//        strengthBarsStackView.axis = .horizontal
//        addSubview(strengthBarsStackView)
//        strengthBarsStackView.topAnchor.constraint(equalToSystemSpacingBelow: txtFieldContainerView.bottomAnchor, multiplier: 1).isActive = true
//        strengthBarsStackView.leadingAnchor.constraint(equalTo: txtFieldContainerView.leadingAnchor).isActive = true
//        strengthBarsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        strengthBarsStackView.translatesAutoresizingMaskIntoConstraints = false
//        strengthBarsStackView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
//        strengthBarsStackView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
//        strengthBarsStackView.spacing = 8
        }
    
    @objc func showHidePasswordToggle() {
       textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry == false {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    func passwordStrength(_ password: String) {
        var passStrength: passStrength
        switch password.count {
    case 0...9 :
    passStrength = .weak
    case 10...19 :
    passStrength = .medium
    default:
    passStrength = .strong
}
self.password = password
strengthBarColors(passStrength)
sendActions(for: [.valueChanged])
}
    func strengthBarColors(_ passwordStrength: passStrength) {
        switch passwordStrength {
        case .weak :
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = passwordStrength.rawValue
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = passwordStrength.rawValue
        default :
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = passwordStrength.rawValue
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}


extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        passwordStrength(newText)
        return true
    }
}



