//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: Int {
	case none = 0
	case weak = 5
	case medium = 9
	case strong = 20
	
	var toString: String {
		switch self {
		case .none:
			return "empty"
		case .weak:
			return "weak"
		case .medium:
			return "medium"
		case .strong:
			return "strong"
		}
	}
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
	private (set) var passwordStrength = PasswordStrength.weak
    
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
	}
    
    func setup() {
		backgroundColor = bgColor
		
		//TitleLbl
		
		titleLabel.text = "ENTER PASSWORD"
		titleLabel.textColor = labelTextColor
		titleLabel.font = labelFont
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(titleLabel)
		
		titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: standardMargin).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
		
		//ShowHideBtn
		
		showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
		showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		showHideButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
		
		//PasswordTextField
		
		textField.delegate = self
		textField.backgroundColor = .clear
		textField.borderStyle = .roundedRect
		textField.layer.borderWidth = 2
		textField.layer.borderColor = textFieldBorderColor.cgColor
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.rightView = showHideButton
		textField.rightViewMode = .always
		textField.isSecureTextEntry = true
		
		addSubview(textField)
		
		textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
		textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
		textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin).isActive = true
		textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
		
		//ColorViews
		
		for view in [weakView, mediumView, strongView] {
			view.backgroundColor = unusedColor
			view.translatesAutoresizingMaskIntoConstraints = false
			
			view.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
			view.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
		}
		
		//ColorViewStack
		
		let colorStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
		colorStackView.translatesAutoresizingMaskIntoConstraints = false
		colorStackView.spacing = 2
		
		//StrengthDescriptionLbl
		
		strengthDescriptionLabel.font = labelFont
		strengthDescriptionLabel.textColor = labelTextColor
		
		//StrengthStack
		
		let strengthStackView = UIStackView(arrangedSubviews: [colorStackView, strengthDescriptionLabel])
		strengthStackView.translatesAutoresizingMaskIntoConstraints = false
		strengthStackView.alignment = .center
		strengthStackView.spacing = standardMargin
		
		addSubview(strengthStackView)
		
		strengthStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
		strengthStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
		strengthStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin).isActive = true
    }
	
	@objc private func showHidePassword(sender: UIButton) {
		textField.isSecureTextEntry.toggle()
		showHideButton.setImage(UIImage(named: textField.isSecureTextEntry ? "eyes-closed" : "eyes-open"), for: .normal)
	}
	
	private func determineStrength(of password: String) {
		switch password.count {
		case (PasswordStrength.none.rawValue + 1)...PasswordStrength.weak.rawValue:
			passwordStrength = .weak
		case (PasswordStrength.weak.rawValue + 1)...PasswordStrength.medium.rawValue:
			passwordStrength = .medium
		case (PasswordStrength.medium.rawValue + 1)...PasswordStrength.strong.rawValue:
			passwordStrength = .strong
		default:
			passwordStrength = .none
		}
		
		if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: password) {
			switch passwordStrength {
			case .strong:
				passwordStrength = .medium
			case .medium:
				passwordStrength = .weak
			default:
				passwordStrength = .none
			}
		}
		
		self.password = password
		updateStrengthColor()
		sendActions(for: [.valueChanged])
	}
	
	private func updateStrengthColor() {
		switch passwordStrength {
		case .none:
			weakView.backgroundColor = unusedColor
			mediumView.backgroundColor = unusedColor
			strongView.backgroundColor = unusedColor
		case .weak:
			weakView.backgroundColor = weakColor
			mediumView.backgroundColor = unusedColor
			strongView.backgroundColor = unusedColor
		case .medium:
			weakView.backgroundColor = weakColor
			mediumView.backgroundColor = mediumColor
			strongView.backgroundColor = unusedColor
		case .strong:
			weakView.backgroundColor = weakColor
			mediumView.backgroundColor = mediumColor
			strongView.backgroundColor = strongColor
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		endEditing(true)
	}
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
		
        // TODO: send new text to the determine strength method
		if newText.count <= PasswordStrength.strong.rawValue {
			determineStrength(of: newText)
			return true
		}
		
		return false
    }
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		endEditing(true)
		return true
	}
}
