//
//  NewPasswordField.swift
//  PasswordTextField
//
//  Created by Percy Ngan on 9/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class NewPasswordField: UIControl {

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
		backgroundColor = .blue
		setup()
	}

	private func setup() {

		layer.cornerRadius = 8
		backgroundColor = .blue
		leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		heightAnchor.constraint(equalToConstant: 200)

	}
}
