//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@IBDesignable
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

	// MARK: - Properties
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
        // Lay out your subviews here

		layer.cornerRadius = 0
		backgroundColor = bgColor

		NSLayoutConstraint.activate([
			leadingAnchor.constraint(equalTo: self.leadingAnchor),
			topAnchor.constraint(equalTo: self.topAnchor),
			trailingAnchor.constraint(equalTo: self.trailingAnchor),
			heightAnchor.constraint(equalToConstant: 109)
			])

        addSubview(titleLabel)
		titleLabel.text = "Enter password"
		titleLabel.font = labelFont
		titleLabel.textColor = labelTextColor

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
			titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
			titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -15)
			])

		// Password Container
		addSubview(textFieldContainerView)
		textFieldContainerView.layer.borderColor = textFieldBorderColor.cgColor
		textFieldContainerView.layer.borderWidth = 1.5
		textFieldContainerView.layer.cornerRadius = 5.0

		textFieldContainerView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			textFieldContainerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			textFieldContainerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),
			textFieldContainerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			textFieldContainerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
			])

		// MARK: - Add Password text Field
		textFieldContainerView.addSubview(textField)
		textField.placeholder = "testing"
		textField.isSecureTextEntry = true
		textField.rightView = showHideButton
		textField.rightViewMode = .always
		textField.delegate = self
		textField.becomeFirstResponder()

		textField.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			textField.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: standardMargin),
			textField.topAnchor.constraint(equalTo: textFieldContainerView.topAnchor, constant: standardMargin),
			textField.trailingAnchor.constraint(equalTo: textFieldContainerView.trailingAnchor, constant: -standardMargin),
			textField.bottomAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: -standardMargin)
			])

		showHideButton.translatesAutoresizingMaskIntoConstraints = false
		showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
		showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)

		// MARK: - Color Views: weak, medium, strong
		weakView.translatesAutoresizingMaskIntoConstraints = false
		weakView.backgroundColor = unusedColor
		weakView.layer.cornerRadius = colorViewSize.height / 2
		weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
		weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true

		mediumView.translatesAutoresizingMaskIntoConstraints = false
		mediumView.backgroundColor = unusedColor
		mediumView.layer.cornerRadius = colorViewSize.height / 2
		mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
		mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true

		strongView.translatesAutoresizingMaskIntoConstraints = false
		strongView.backgroundColor = unusedColor
		strongView.layer.cornerRadius = colorViewSize.height / 2
		strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
		strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true

		// Add all the colorViews to the stackView
		let stackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])

		addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.spacing = 2.0
		stackView.alignment = .center

		stackView.leadingAnchor.constraint(equalTo: textFieldContainerView.leadingAnchor, constant: standardMargin).isActive = true
		stackView.topAnchor.constraint(equalTo: textFieldContainerView.bottomAnchor, constant: standardMargin * 2).isActive = true


    }

	@objc func showPassword(_ sender: UIButton) {

		textField.isSecureTextEntry.toggle()

		switch textField.isSecureTextEntry {
		case true:
			showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
		default:
			showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
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
