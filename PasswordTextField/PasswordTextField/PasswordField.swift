//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrengthIndicator: String {
    case unusedColor = ""
    case weakColor = "Too Weak"
    case mediumColor = "Could be Stronger"
    case strongColor = "Strong Password"
}


class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passWordStrength: PasswordStrengthIndicator = .unusedColor
    private var stackView: UIStackView!
    

    private let textFieldContainerView: UIView = UIView()
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldContainerWidth: CGFloat = 100.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let textFieldBorderWidth: CGFloat = 1
    
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
    
    func setup() {
        // Lay out your subviews here
        
        
//        layer.cornerRadius = 10
        self.backgroundColor = bgColor
        
        

        // Enter Password Label
         addSubview(titleLabel)
        
       
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = labelTextColor
        titleLabel.backgroundColor = bgColor
        titleLabel.font = labelFont
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textAlignment = .left
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        
        let titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel,
                                                         attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: self.safeAreaLayoutGuide,
                                                         attribute: .top,
                                                         multiplier: 1,
                                                         constant: standardMargin)
        
        let titleLabelTrailingConstraint = NSLayoutConstraint(item: titleLabel,
                                                         attribute: .trailing,
                                                         relatedBy: .equal,
                                                         toItem: self.safeAreaLayoutGuide,
                                                         attribute: .trailing,
                                                         multiplier: 1,
                                                         constant: -standardMargin)
        
        NSLayoutConstraint.activate([
        titleLabelTopConstraint,
        titleLabelTrailingConstraint
        ])

       
        
        // Password Textfield
        addSubview(textFieldContainerView)
        
        textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainerView.backgroundColor = bgColor
        
        textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainerView.layer.borderWidth = textFieldBorderWidth
        textFieldContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        textFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textFieldContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textFieldContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
        
        
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    

    private func configueStackView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
           
        ])
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
