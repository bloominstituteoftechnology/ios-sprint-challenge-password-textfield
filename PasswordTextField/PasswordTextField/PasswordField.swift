//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthPasswordCondtion: String {
    case tooWeak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong Password"
}
class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    var condition: StrengthPasswordCondtion = .medium
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
    
    private var textFieldBorderLine: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
   
    
    func setup() {
        // Lay out your subviews here

        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.text = "ENTER YOUR PASSWORD"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
       textFieldBorderLine.translatesAutoresizingMaskIntoConstraints = false
        textFieldBorderLine.layer.borderColor = textFieldBorderColor.cgColor
        textFieldBorderLine.backgroundColor = bgColor
        textFieldBorderLine.layer.borderWidth = 2
        textFieldBorderLine.layer.cornerRadius = 6
        addSubview(textFieldBorderLine)
        textField.textContentType = .password
        textField.placeholder = "Write a Password"
        textField.delegate = self
        textField.isSecureTextEntry = true
        addSubview(textField)
        
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(changeHideButton), for: .touchUpInside)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        strongView.layer.backgroundColor = strongColor.cgColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        
        mediumView.layer.backgroundColor = mediumColor.cgColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        
        weakView.layer.backgroundColor = weakColor.cgColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        
        strengthDescriptionLabel.text = condition.rawValue
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
//        Constraint Time!
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func changeHideButton() {
        if textField.isSecureTextEntry == true {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
