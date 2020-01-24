//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl,UITextFieldDelegate {
    
    // Public API - these prop erties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private var standardMargin: CGFloat = 8.0
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
    
    
    func setup() {
        //         Lay out your subviews here
        //        titleLabel
        backgroundColor = bgColor
        self.addSubview(titleLabel)
        titleLabel.text = " Enter Password "
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
//        Constraints
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        
        
//        NSLayoutConstraint(item: titleLabel,
//                           attribute: .top,
//                           relatedBy: .equal,
//                           toItem: self,
//                           attribute: .bottom,
//                           multiplier: 1,
//                           constant: 4).isActive = true
//
//        NSLayoutConstraint(item: titleLabel,
//                           attribute: .leading,
//                           relatedBy: .equal,
//                           toItem: self,
//                           attribute: .leading,
//                           multiplier: 1,
//                           constant: 2).isActive = true
//
//        NSLayoutConstraint(item: titleLabel,
//                           attribute: .trailing,
//                           relatedBy: .equal,
//                           toItem: self,
//                           attribute: .trailing,
//                           multiplier: 1,
//                           constant: -2).isActive = true
        //        textField
        
        let textField = UITextField()
        self.addSubview(textField)
        
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 3.0
        textField.layer.borderWidth = 3.0
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
//        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        NSLayoutConstraint(item: textField,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: titleLabel,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 4).isActive = true

        NSLayoutConstraint(item: textField,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 2).isActive = true

        NSLayoutConstraint(item: textField,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -2).isActive = true
        
//        hidden button
//        leading/trailing center y and leading
        
        
        
//
//
//        //               strengthDescripton label

        let strengthDescriptionLabel = UILabel()
        self.addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.text = " Too Weak "
        strengthDescriptionLabel.textAlignment = .center
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: standardMargin).isActive = true
        
        
        
        let showHideButton = UIButton()
        self.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setTitle("🕶", for: .normal)
        
        
        showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).isActive = true
        

//        showHideButton.addTarget(self, action: #selector(showHideButtonTapped(_:)), for: .touchUpInside)


//        NSLayoutConstraint(item: strengthDescriptionLabel,
//                           attribute: .top,
//                           relatedBy: .equal,
//                           toItem: textField,
//                           attribute: .bottom,
//                           multiplier: 1,
//                           constant: 4).isActive = true
//
//        NSLayoutConstraint(item: strengthDescriptionLabel,
//                           attribute: .leading,
//                           relatedBy: .equal,
//                           toItem: self,
//                           attribute: .leading,
//                           multiplier: 1,
//                           constant: 2).isActive = true
//
//        NSLayoutConstraint(item: strengthDescriptionLabel,
//                           attribute: .trailing,
//                           relatedBy: .equal,
//                           toItem: self,
//                           attribute: .trailing,
//                           multiplier: 1,
//                           constant: -2).isActive = true
        
        //        Views
        
        let weakView = UIView()
        self.addSubview(weakView)
        weakView.sizeThatFits(colorViewSize)
        weakView.backgroundColor = weakColor
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        
        let mediumView = UIView()
        self.addSubview(mediumView)
mediumView.layer.backgroundColor = mediumColor.cgColor
        mediumView.backgroundColor = mediumColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        mediumView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
        let strongView = UIView()
        self.addSubview(strongView)
        strongView.layer.backgroundColor = strongColor.cgColor
        strongView.backgroundColor = strongColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        strongView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        
   
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func passwordLength() {
        
    }
    
    @objc private func showHideButtonTapped() {
        showHideButton.isEnabled = true
    
    }
    // Func that gets the length of the string and makes changes to the weak, medium, strong views accordingly
    // Func that handles the animations of the labels.
}

extension PasswordField {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
    
    func updateViews() {
        
    }
}
