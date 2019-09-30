//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
	case weak = "too weak"
	case medium =  "could be stronger"
	case strong = "strong password"
}

class PasswordField: UIControl {

	private var passwordSecure: Bool = true
    
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
	private var securityButton: UIButton = UIButton(type: .custom)


	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}



    
    func setup() {

		layer.cornerRadius = 8
		leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		//bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 50).isActive = true
		heightAnchor.constraint(equalToConstant: 109).isActive = true
		backgroundColor = bgColor

		// Enter password label
		addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
		titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true

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
		textFieldContainerView.addSubview(textField)
		//textFieldContainerView.addSubview(showHideButton)
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: standardMargin).isActive = true
		textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: standardMargin).isActive = true
		textField.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -standardMargin).isActive = true
		textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -standardMargin).isActive = true

		textField.placeholder = "testing"
		textField.isSecureTextEntry = true
		textField.rightView = showHideButton
		textField.rightViewMode = .always
		textField.delegate = self
		textField.becomeFirstResponder()
		//.layer.borderColor = textFieldBorderColor.cgColor
		//textField.layer.borderWidth = 2.0




		 // Show/Hide Button
		//addSubview(showHideButton)
		// Why does commenting this out take out the image?
		showHideButton.translatesAutoresizingMaskIntoConstraints = false
//		showHideButton.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: 0).isActive = true

//		showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8).isActive = true
//
//		showHideButton.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 0).isActive = true
//
//		showHideButton.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 0).isActive = true
//		showHideButton.heightAnchor.constraint(equalToConstant: 50)
//		showHideButton.widthAnchor.constraint(equalToConstant: 50)
//		showHideButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		//showHideButton.setTitle("Show", for: .normal)
		showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
		showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)

		// Color views
		//addSubview(weakView)
		weakView.translatesAutoresizingMaskIntoConstraints = false
		weakView.backgroundColor = unusedColor
		weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
		weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
		weakView.layer.cornerRadius = colorViewSize.height / 2

		//addSubview(mediumView)
		mediumView.translatesAutoresizingMaskIntoConstraints = false
		mediumView.backgroundColor = unusedColor
		mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
		mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
		mediumView.layer.cornerRadius = colorViewSize.height / 2

		//addSubview(strongView)
		strongView.translatesAutoresizingMaskIntoConstraints = false
		strongView.backgroundColor = unusedColor
		strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
		strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
		strongView.layer.cornerRadius = colorViewSize.height / 2


		let stackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])

		// Take out this line to cause an error and not being able to see subviews

		addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: standardMargin).isActive = true
		stackView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: standardMargin * 2).isActive = true

		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.spacing = 2.0
		stackView.alignment = .center


		addSubview(strengthDescriptionLabel)
		strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: standardMargin).isActive = true
		strengthDescriptionLabel.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: standardMargin).isActive = true

		strengthDescriptionLabel.text = "testing"
		strengthDescriptionLabel.font = labelFont
		strengthDescriptionLabel.textColor = labelTextColor
    }




	@objc func showPassword(_ sender: UIButton) {
		print("click")



		textField.isSecureTextEntry.toggle()

		if textField.isSecureTextEntry {
			showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
			textField.isSecureTextEntry = false
		} else {
			showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
			textField.isSecureTextEntry = true
		}
	}

	func passwordStrengthCheck(_ password: String) {

		let strong = "Strong"
		let medium = "Medium"
		let weak = "Weak"

		let count = password.count

		if count < 9 {
			weakView.backgroundColor = weakColor
			strengthDescriptionLabel.text = "Password strength: \(weak)"
		} else if count < 16 {
			weakView.backgroundColor = weakColor
			mediumView.backgroundColor = mediumColor
			strongView.backgroundColor = strongColor
			strengthDescriptionLabel.text = "Password strength: \(strong)"
		}
	}

	private func saveText() {

	}

}


extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method

		self.passwordStrengthCheck(newText)
		
        return true
    }
}
