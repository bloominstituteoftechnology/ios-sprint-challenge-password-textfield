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
		}
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
    
    private var titleLabel: UILabel = UILabel()
	private var textFieldContainerView: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()

	private let strengthIndicatorStackView: UIStackView = UIStackView()
	private let allElementsStackview: UIStackView = UIStackView()
	private let strengthBarsStackview: UIStackView = UIStackView()
    
    private func setup() {
        // Lay out your subviews here

		[allElementsStackview].forEach {
			addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}

		titleLabel.text = "ENTER PASSOWRD"
		titleLabel.font = labelFont
		titleLabel.textColor = labelTextColor

		strengthDescriptionLabel.text = "Weak"

		textField.isSecureTextEntry = true
		textField.layer.borderColor = textFieldBorderColor.cgColor
		textField.layer.borderWidth = 2
		textField.layer.cornerRadius = 8
//		[textField, showHideButton].forEach { textFieldContainerView.addSubview($0) }
		textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true

//		addSubview(showHideButton)
		showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
		allElementsStackview.alignment = .fill
		allElementsStackview.axis = .vertical
		strengthBarsStackview.spacing = 5
		allElementsStackview.spacing = standardMargin
		[weakView, mediumView, strongView].forEach {
			strengthBarsStackview.addArrangedSubview($0)
//			$0.sizeToFit()
//			$0.sizeThatFits(colorViewSize)
			$0.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
			$0.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
			$0.backgroundColor = unusedColor
		}
		[titleLabel, textField, strengthIndicatorStackView].forEach { allElementsStackview.addArrangedSubview($0) }
		[strengthBarsStackview, strengthDescriptionLabel].forEach { strengthIndicatorStackView.addArrangedSubview($0) }


		NSLayoutConstraint.activate([
				allElementsStackview.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
				allElementsStackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin),
				allElementsStackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -standardMargin),
				allElementsStackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
//				textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
//				textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: textFieldMargin),
//				textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: 0),
//				textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: 0),
//				textField.trailingAnchor.constraint(equalTo: showHideButton.leadingAnchor, constant: standardMargin),
//				showHideButton.rightAnchor.constraint(equalTo: textFieldContainerView.rightAnchor, constant: -standardMargin),
//				showHideButton.centerXAnchor.constraint(equalTo: textFieldContainerView.centerXAnchor, constant: 0)
			])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

	private func changeStrengthBarColor() {
		if let passwordStrength = passwordStrength {
			switch passwordStrength {
			case .tooWeak:
				weakView.backgroundColor = weakColor
				strengthDescriptionLabel.text = passwordStrength.rawValue
			case .couldBeStronger:
				weakView.backgroundColor = weakColor
				mediumView.backgroundColor = mediumColor
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

	func determinePasswordStrength() {
		if password.count <= 9 {
			passwordStrength = .tooWeak
		} else if (10...19).contains(password.count) {
			passwordStrength = .couldBeStronger
		} else {
			passwordStrength = .strong
		}
	}

	@objc private func showPassword() {

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
}
