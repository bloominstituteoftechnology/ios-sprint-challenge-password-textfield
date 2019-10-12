//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

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
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    func setup() {
        
        // Turning off automatic resizing
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding Subviews
        addSubview(titleLabel)
        addSubview(textField)
        textField.addSubview(showHideButton)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        
        // Hiding views until prerequisites met
        weakView.isHidden = true
        mediumView.isHidden = true
        strongView.isHidden = true
        
        // Misc
        
        /// Misc
        titleLabel.text = "ENTER PASSWORD"
        textField.layer.borderWidth = 2
        
        /// Colors
        titleLabel.textColor = labelTextColor
        self.backgroundColor = bgColor
        textField.layer.borderColor = textFieldBorderColor.cgColor
        weakView.layer.backgroundColor = weakColor.cgColor
        mediumView.layer.backgroundColor = mediumColor.cgColor
        strongView.layer.backgroundColor = strongColor.cgColor
        
        // Button
        showHideButton.addTarget(self, action: #selector(showHideButtonAction), for: .touchUpInside)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        
        // Adding Constraints
        
        /// Password strength views
        let weakViewHeight = weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        let weakViewWidth = weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        let weakViewBottom = weakView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1 * standardMargin)
        
        let mediumViewHeight = mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        let mediumViewWidth = mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        let mediumViewBottom = mediumView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1 * standardMargin)
        let mediumViewLeading = mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin)
        
        let strongViewHeight = strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        let strongViewWidth = strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width)
        let strongViewBottom = strongView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1 * standardMargin)
        let strongViewLeading = strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin)
        
        self.addConstraints([weakViewWidth, weakViewHeight, weakViewBottom,
                            mediumViewHeight, mediumViewWidth, mediumViewBottom, mediumViewLeading,
                            strongViewHeight, strongViewWidth, strongViewBottom, strongViewLeading
        ])
        
        /// TextField
        let textFieldHeight = textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        let textFieldLeading = textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textFieldMargin)
        let textFieldTrailing = textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1 * textFieldMargin)
        let textFieldCenterY = textField.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        self.addConstraints([textFieldHeight, textFieldLeading, textFieldTrailing, textFieldCenterY])
        
        /// ShowHideButton
        let showHideButtonTrailing = showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -4 * standardMargin)
        let showHideButtonCenterY = showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        self.addConstraints([showHideButtonTrailing, showHideButtonCenterY])
        
    }
    
    func determineStrength(string: String) {
        
        if string.count >= 0 && string.count <= 9 {
            weakView.isHidden = false
            mediumView.isHidden = true
            strongView.isHidden = true
        } else if string.count >= 10 && string.count <= 19  {
            weakView.isHidden = false
            mediumView.isHidden = false
            strongView.isHidden = true
        } else if string.count >= 20 {
            weakView.isHidden = false
            mediumView.isHidden = false
            strongView.isHidden = false
        }
    }
    
    @objc func showHideButtonAction() {
        
        // Setting image for Show/Hide Button
        if showHideButton.isSelected == true {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            showHideButton.isSelected = false
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            showHideButton.isSelected = true
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
    
        determineStrength(string: newText)

        return true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.backgroundColor = UIColor.green
//        print("Editing did begin")
//    }
}
