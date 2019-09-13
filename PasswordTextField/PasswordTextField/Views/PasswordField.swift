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

	private(set) var passwordStrength: PasswordStrength? {
		didSet {
			changeStrengthBarColor()
			determineAnimation()
		}
	}
    
    // Public API - these properties are used to fetch the final password and strength values
	private (set) var password: String = "" {
		didSet {
			determinePasswordStrength()
		}
	}
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)

	// Label Attributes
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)

	// TextField and View Attributes
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)

	// Properties
    private var titleLabel: UILabel = UILabel()
	private var textFieldContainerView: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()

	private let allElementsStackview: UIStackView = UIStackView()
	private let strengthBarsStackview: UIStackView = UIStackView()

	// View Setup
    private func setup() {
		layer.cornerRadius = 8
		backgroundColor = bgColor

		// Add subviews
		[titleLabel, textField, strengthBarsStackview].forEach { allElementsStackview.addArrangedSubview($0) }
		[weakView, mediumView, strongView, strengthDescriptionLabel].forEach {
			strengthBarsStackview.addArrangedSubview($0)
		}

		// Size & Spacing
		textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
		textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
		allElementsStackview.alignment = .fill
		allElementsStackview.distribution = .fill
		allElementsStackview.axis = .vertical
		strengthBarsStackview.alignment = .center
		strengthBarsStackview.distribution = .fill
		strengthBarsStackview.spacing = standardMargin

		// TextField Setup
		textField.isSecureTextEntry = true
		textField.layer.borderColor = textFieldBorderColor.cgColor
		textField.layer.borderWidth = 2
		textField.layer.cornerRadius = 8
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin * 2, height: textFieldContainerHeight))
		textField.leftViewMode = .always
		textField.rightView = showHideButton
		textField.rightViewMode = .always
		textField.clearButtonMode = .whileEditing

		// Additional Setup
		titleLabel.text = "ENTER PASSOWRD"
		titleLabel.font = labelFont
		titleLabel.textColor = labelTextColor
		allElementsStackview.spacing = standardMargin
		[allElementsStackview].forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		strengthDescriptionLabel.text = "Strength"
		strengthDescriptionLabel.font = labelFont
		showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
		showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
		showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
		showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
		[weakView, mediumView, strongView].forEach {
			$0.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
			$0.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
			$0.layer.cornerRadius = colorViewSize.height / 2
			$0.backgroundColor = unusedColor
		}

		// Constraints
		NSLayoutConstraint.activate([
				allElementsStackview.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
				allElementsStackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin),
				allElementsStackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -standardMargin),
				allElementsStackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
				strengthBarsStackview.heightAnchor.constraint(equalToConstant: 16)
			])
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
		textField.delegate = self
    }


	// MARK: - Helper Methods

	private func changeStrengthBarColor() {
		if let passwordStrength = passwordStrength,
			let input = textField.text,
			!input.isEmpty {
			switch passwordStrength {
			case .tooWeak:
				weakView.backgroundColor = weakColor
				strengthDescriptionLabel.text = passwordStrength.rawValue
				mediumView.backgroundColor = unusedColor
				strongView.backgroundColor = unusedColor
			case .couldBeStronger:
				weakView.backgroundColor = weakColor
				mediumView.backgroundColor = mediumColor
				strongView.backgroundColor = unusedColor
				strengthDescriptionLabel.text = passwordStrength.rawValue
			case .strong:
				weakView.backgroundColor = weakColor
				mediumView.backgroundColor = mediumColor
				strongView.backgroundColor = strongColor
				strengthDescriptionLabel.text = passwordStrength.rawValue
			}
		} else {
			[weakView, mediumView, strongView].forEach { $0.backgroundColor = unusedColor}
		}
	}

	private func determineAnimation() {
		switch password.count {
		case 0:
			weakView.performFlare()
		case 1:
			weakView.performFlare()
		case 10:
			mediumView.performFlare()
		case 20:
			strongView.performFlare()
		default:
			break
		}
	}


	private func determinePasswordStrength() {
		if password.count <= 9 {
			passwordStrength = .tooWeak
		} else if (10...19).contains(password.count) {
			passwordStrength = .couldBeStronger
		} else {
			passwordStrength = .strong
		}
	}


	@objc private func showPassword() {
		switch textField.isSecureTextEntry {
		case true:
			textField.isSecureTextEntry = false
			showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
		case false:
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
		password = newText
        return true
    }

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
