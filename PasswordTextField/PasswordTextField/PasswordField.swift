//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthLevel {
    case weak
    case medium
    case strong
}

class PasswordField: UIControl {
    
    var passwordStrength: StrengthLevel = .weak
    
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    private let strengthLabelFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    
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

        initializeView(for: titleLabel)
        initializeView(for: textField)
        initializeView(for: weakView)
        initializeView(for: mediumView)
        initializeView(for: strongView)
        initializeView(for: strengthDescriptionLabel)
        initializeView(for: showHideButton)
        
        backgroundColor = bgColor
        
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        switch passwordStrength {
        case .weak:
            strengthDescriptionLabel.text = "Too weak"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case .medium:
            strengthDescriptionLabel.text = "Could be stronger"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case .strong:
            strengthDescriptionLabel.text = "Strong password"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = strengthLabelFont

        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 5.0
        textField.layer.borderWidth = 2.0
        textField.backgroundColor = bgColor
        textField.delegate = self
        
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: textFieldContainerHeight),
            
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -textFieldMargin),
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -textFieldMargin),
            
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10.0),
            weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10.0),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2.0),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10.0),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2.0),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5.0),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: textFieldMargin),
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func initializeView(for aView: UIView) {
        addSubview(aView)
        aView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func showHideButtonTapped() {
        
    }
    
    func determineStrength(with charcterCount: Int) {
        if charcterCount < 9 {
            passwordStrength = .weak
            setup()
        } else if charcterCount <= 19 {
            passwordStrength = .medium
            setup()
        } else {
            passwordStrength = .strong
            setup()
        }
    }

    
}


extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        determineStrength(with: newText.count)
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let password = textField.text, !password.isEmpty {
            self.password = password
        }
        
        self.endEditing(true)
        return false
    }
}
