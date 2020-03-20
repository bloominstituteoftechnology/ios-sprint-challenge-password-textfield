//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // MARK: - Properties
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0  // FIXME: Use Me
    private let textFieldMargin: CGFloat = 6.0 // FIXME: Use Me
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0) // FIXME: Use Me
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1) // FIXME: Use Me
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1) // FIXME: Use Me
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1) // FIXME: Use Me
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1) // FIXME: Use Me
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1) // FIXME: Use Me
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1) // FIXME: Use Me
    
    private var titleLabel: UILabel = UILabel() // FIXME: Use Me
    private var textField: UITextField = UITextField() // FIXME: Use Me
    private var showHideButton: UIButton = UIButton() // FIXME: Use Me
    private var weakView: UIView = UIView() // FIXME: Use Me
    private var mediumView: UIView = UIView() // FIXME: Use Me
    private var strongView: UIView = UIView() // FIXME: Use Me
    private var strengthDescriptionLabel: UILabel = UILabel() // FIXME: Use Me
    
    func setup() {
        // Lay out your subviews here
        
        // ---- titleLabel -----------------------------
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        titleLabel.text = "Enter Password"

        titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                       constant: standardMargin).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: standardMargin).isActive = true
        
        // FIXME: titleLabel.heightAnchor
        
    }
    
    // MARK: - Initializers
    
    // TODO: ? This wasn't here but didn't seem necessary. Why?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
