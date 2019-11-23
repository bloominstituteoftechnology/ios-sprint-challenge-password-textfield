//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable class PasswordField: UIControl {
    
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
    private var weakView :UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        addSubview(textField)
        addSubview(strengthDescriptionLabel)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        

        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
       
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .normal)
        showHideButton.addTarget(self, action: #selector(toggleShowPassword), for: .touchUpInside)
        textField.rightViewMode = .always
        textField.rightView = showHideButton
    
        
        weakView.backgroundColor = weakColor
        weakView.frame = CGRect(x: textField.frame.size.width + 5, y: textField.frame.size.height + 65, width: 60, height: 5)

        mediumView.backgroundColor = unusedColor
        mediumView.frame = CGRect(x: weakView.frame.size.width + 10, y: textField.frame.size.height + 65, width: 60, height: 5)
       
        strongView.backgroundColor = unusedColor
        strongView.frame = CGRect(x: mediumView.frame.size.width + 75, y: textField.frame.size.height + 65, width: 60, height: 5)

        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 5).isActive = true
        strengthDescriptionLabel.text = "Too Weak"
        
        
        
        
    }
    

    
    @objc func toggleShowPassword() {
        if textField.isSecureTextEntry == false {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        } else if textField.isSecureTextEntry == true {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
}



extension PasswordField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = self.textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        switch newText.count {
        case 1...8:
            strengthDescriptionLabel.text = "Too Weak"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 9...19: strengthDescriptionLabel.text = "Could be Stronger"
            weakView.backgroundColor = weakColor
                       mediumView.backgroundColor = mediumColor
                       strongView.backgroundColor = unusedColor
        case 20...2000: strengthDescriptionLabel.text = "Strong Password"
            weakView.backgroundColor = weakColor
                       mediumView.backgroundColor = mediumColor
                       strongView.backgroundColor = strongColor
        default: strengthDescriptionLabel.text = "Too Weak"
            weakView.backgroundColor = weakColor
                    mediumView.backgroundColor = unusedColor
                    strongView.backgroundColor = unusedColor
        }
        
 
        return true
    }
    

}
