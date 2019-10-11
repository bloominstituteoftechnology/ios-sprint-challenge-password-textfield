//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case tooWeak = "Too Weak"
    case couldBeStronger = "Could Be Stronger"
    case strong = "Strong Password"
}


class PasswordField: UIControl {
    
    // MARK: Properties
    private var passwordStrength: PasswordStrength? {
        
    }
    
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
    
    // MARK: Properties
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    private var textFieldContainerView: UIView = UIView()
    private var allElementsStackView: UIStackView = UIStackView()
    private var strengthBarsStackView: UIStackView = UIStackView()
    
    // MARK: Setup Func
    func setup() {
        // Lay out your subviews here
        layer.cornerRadius = 8
        backgroundColor = bgColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: AddSubviews
        [titleLabel, textField, strengthBarsStackView].forEach {
            allElementsStackView.addArrangedSubview($0) }
        [weakView, mediumView, strongView, strengthDescriptionLabel].forEach {
            strengthBarsStackView.addArrangedSubview($0)
        }
        
        // MARK: Size & Spacing
        textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        allElementsStackView.alignment = .fill
        allElementsStackView.distribution = .fill
        allElementsStackView.axis = .vertical
        
        strengthBarsStackView.alignment = .center
        strengthBarsStackView.distribution = .fill
        strengthBarsStackView.spacing = standardMargin
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
// MARK: PasswordField Extension
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        password = newText
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
