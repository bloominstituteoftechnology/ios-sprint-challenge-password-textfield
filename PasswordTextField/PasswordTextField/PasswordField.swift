//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable
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
        
        titleLabel.text = " ENTER PASSWORD "
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
                           attribute: .top,
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
        //        textField
        
        
        let textField = UITextField()
        self.addSubview(textField)
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 3.0
        textField.layer.borderWidth = 3.0
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        
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
        // Button
        
        let showHideButton = UIButton()
        self.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setTitle( "  ", for: .normal)
        
        
        showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6).isActive = true
        
        
        
        //               strengthDescripton label
        
        let strengthDescriptionLabel = UILabel()
        strengthDescriptionLabel.text = " Too Weak "
        strengthDescriptionLabel.textAlignment = .right
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
                           constant: 32).isActive = true
        
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
                           constant: -60).isActive = true
        
        //        Views
        
        
        let weakView = UIView()
        
        weakView.layer.backgroundColor = weakColor.cgColor
        weakView.backgroundColor = weakColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(weakView)
        
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        NSLayoutConstraint(item: weakView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: textField,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 40).isActive = true
        
        weakView.trailingAnchor.constraint(equalTo: weakView.safeAreaLayoutGuide.trailingAnchor, constant: 10).isActive = true
        
        
        let mediumView = UIView()
        mediumView.layer.backgroundColor = mediumColor.cgColor
        mediumView.backgroundColor = mediumColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        self.addSubview(mediumView)
        
        NSLayoutConstraint(item: mediumView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: textField,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 40).isActive = true
        
        
        
        NSLayoutConstraint(item: mediumView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 70).isActive = true
        
        let strongView = UIView()
        strongView.layer.backgroundColor = strongColor.cgColor
        strongView.backgroundColor = strongColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.addSubview(strongView)
        
        NSLayoutConstraint(item: strongView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: textField,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 40).isActive = true
        
        
        
        NSLayoutConstraint(item: strongView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 140).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    
    func passwordLength(newText: String) {
        
        
        let passwordChars = newText.count
        switch passwordChars {
        case 1...5:
            strengthDescriptionLabel.text = " Too Weak "
            
            
        case 5...10:
            strengthDescriptionLabel.text = " Medium Strength "
            
        case 10...30:
            strengthDescriptionLabel.text = " Strong Password "
            
        default:
            strengthDescriptionLabel.text = " Too Weak "
            
        }
        
        enum passwordStrength {
            case  weak
            case medium
            case strong
        }
        
        
        
        //        let password = 1...16
        //        textField.resignFirstResponder()
        //        if textField.text = 1...5 {
        //            strengthDescriptionLabel.text = "Too Weak"
    }
    
    
    
    
    
    @objc private func showHideButtonTapped(sender: UIButton) {
        showHideButton.isEnabled = true
        textField.isHidden = true
        self.weakView.frame.size.width += 2
        self.weakView.frame.size.height += 2
        }
        
        
        
        
    }
    // Func that gets the length of the string and makes changes to the weak, medium, strong views accordingly
    
    
    // Func that handles the animations of the labels.
    
    
    
    



extension PasswordField {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        passwordLength(newText: newText)
        // TODO: send new text to the determine strength method
        return true
    }
    
    func updateViews() {
      
        
    }
}


