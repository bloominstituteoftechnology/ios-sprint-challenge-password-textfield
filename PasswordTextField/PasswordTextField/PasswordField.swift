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
	private var textFieldContainerView: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()


	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
    
    func setup() {

		backgroundColor = bgColor

		// Enter password label
		addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
		titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true

		titleLabel.text = "ENTER PASSWORD"
		titleLabel.font = labelFont
		titleLabel.textColor = labelTextColor

		// Password Container
		addSubview(textFieldContainerView)
		textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
		textFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		textFieldContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
		textFieldContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true

		textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
		textFieldContainerView.layer.borderWidth = 1.5
		textFieldContainerView.layer.cornerRadius = 5.0

		// Password text Field
		addSubview(textField)
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 8).isActive = true
		textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
		textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -8).isActive = true
		textField.heightAnchor.constraint(equalToConstant: 30).isActive = true

		textField.placeholder = "testing"
		//textField.isSecureTextEntry = true
		textField.rightView = showHideButton
		textField.rightViewMode = .always
		textField.delegate = self



		 // Show/Hide Button
		addSubview(showHideButton)
		showHideButton.translatesAutoresizingMaskIntoConstraints = false
		showHideButton.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 8).isActive = true
		showHideButton.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -8).isActive = true

		showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
		showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)

    }

	@objc private func showPassword(sender: UIButton) {

		if textField.isSecureTextEntry {
			showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
			textField.isSecureTextEntry = false
		} else {
			showHideButton.setImage(UIImage(named: "eyes=closed"), for: .normal)
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
