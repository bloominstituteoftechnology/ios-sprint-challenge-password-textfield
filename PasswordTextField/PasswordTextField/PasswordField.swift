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
        titleLabel.text = " Enter Password "
        titleLabel.textAlignment = .center
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        
        self.addSubview(titleLabel)
     
        NSLayoutConstraint(item: titleLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 4).isActive = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 2).isActive = true
        
        NSLayoutConstraint(item: titleLabel,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -2).isActive = true
        
        let textField = UITextField()
       
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
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
               
        
        
        
        
        strengthDescriptionLabel.text = " Too Weak "
        strengthDescriptionLabel.textAlignment = .center
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        self.addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: strengthDescriptionLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: textField,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 4).isActive = true
        
        NSLayoutConstraint(item: strengthDescriptionLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 2).isActive = true
        
        NSLayoutConstraint(item: strengthDescriptionLabel,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -2).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
