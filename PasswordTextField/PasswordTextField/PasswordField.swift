//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthOfPassword: Int {
	case weak = 0
	case meduim = 9
	case strong = 20
}



class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 15.0
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
	private var titleContainerView: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
		
		// Title Label
		addSubview(titleLabel)
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
		titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
		
		titleLabel.text = "Enter Password:"
		titleLabel.font = labelFont
		
		// Title Container View
		addSubview(titleContainerView)
		titleContainerView.translatesAutoresizingMaskIntoConstraints = false
		titleContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		titleContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1).isActive = true
		titleContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		
		titleContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		titleContainerView.layer.borderColor = UIColor.blue.cgColor
		titleContainerView.layer.borderWidth = 2.0
		titleContainerView.layer.cornerRadius = 5.0
//		titleContainerView.backgroundColor = bgColor
		
		// Text Field
		titleContainerView.addSubview(textField)
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 8).isActive = true
		textField.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 8).isActive = true
		textField.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -8).isActive = true
		textField.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -8).isActive = true
		textField.placeholder = "Password"
		
		
		// Hide Button
		showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
		showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
		textField.rightView = showHideButton
		textField.rightViewMode = .always
		showHideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		
		// Views
		weakView.backgroundColor = weakColor
		weakView.frame.size = colorViewSize
		mediumView.backgroundColor = mediumColor
		mediumView.frame.size = colorViewSize
		strongView.backgroundColor = strongColor
		strongView.frame.size = colorViewSize
		
		// Views Stacked
		let stackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
		stackView.distribution = .fillEqually
		stackView.spacing = 8
		stackView.axis = .horizontal
		
		// Views in stack constraints
		addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
		stackView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
		stackView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
		stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		
		// Strength Description Label
		addSubview(strengthDescriptionLabel)
		strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		strengthDescriptionLabel.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor).isActive = true
		strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView
			.trailingAnchor).isActive = true

		
		strengthDescriptionLabel.text = "Weak"
		strengthDescriptionLabel.font = labelFont
		
		
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

	@objc func buttonTapped() {
		if showHideButton.currentImage!.isEqual(UIImage(named: "eyes-closed")) {
			textField.isSecureTextEntry = false
			showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
		} else {
			textField.isSecureTextEntry = true
			showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
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
