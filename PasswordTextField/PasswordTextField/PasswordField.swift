//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // MARK: - Public API
    // these properties are used to fetch the final password and strength values
    
    private (set) var password: String = ""
    private (set) var currentRelativeStrength: RelativePasswordStrength = .none {
        didSet {
            updateStrengthViews()
        }
    }
    
    enum RelativePasswordStrength: Int, CaseIterable {
        case none
        case weak
        case medium
        case strong
    }
    
    // MARK: - Private Properties
    
    // State
    private var showingPassword: Bool = false
    
    // Subview Settings
    private let standardMargin: CGFloat = 8.0
    private let bottomMargin: CGFloat = 16.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldBorderWidth: CGFloat = 2.0
    private let textFieldCornerRadius: CGFloat = 5.0
    private let textFieldMargin: CGFloat = 6.0
    private let strengthViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let strengthViewRadius: CGFloat = 2.0
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // Password strengths
    private let strengths: [RelativePasswordStrength: (
        minChars: Int,
        text: String,
        color: UIColor,
        view: UIView?
    )] = [
        .none: (
            minChars: 0,
            text: " ",
            color: UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1),
            view: nil),
        .weak: (
            minChars: 1,
            text: "Too weak",
            color: UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1),
            view: UIView()),
        .medium: (
            minChars: 10,
            text: "Could be stronger",
            color: UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1),
            view: UIView()),
        .strong: (
            minChars: 20,
            text: "Strong password",
            color: UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1),
            view: UIView())
    ]
    
    // Subviews
    private var titleLabel: UILabel = UILabel()
    private var textFieldContainer: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    // Strings
    private let titleText = "Enter password"
    private let fieldPlaceholder = "This!saP@$5w0rdyo!!!1"
    private let eyesOpenImage = "eyes-open"
    private let eyesClosedImage = "eyes-closed"
    
    // MARK: - Init/Setup
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // add all subviews and set up for constraining
        [
            titleLabel,
            textFieldContainer,
            strengths[.weak]?.view,
            strengths[.medium]?.view,
            strengths[.strong]?.view,
            strengthDescriptionLabel
        ].forEach { (view) in
            if let view = view {
                view.translatesAutoresizingMaskIntoConstraints = false
                addSubview(view)
            }
        }
        
        // Title label
        titleLabel.text = titleText.uppercased()
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
        
        // Text field container
        textFieldContainer.isUserInteractionEnabled = true
        textFieldContainer.layer.borderWidth = textFieldBorderWidth
        textFieldContainer.layer.borderColor = textFieldBorderColor.cgColor
        textFieldContainer.layer.cornerRadius = textFieldCornerRadius
        textFieldContainer.backgroundColor = bgColor

        NSLayoutConstraint.activate([
            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textFieldContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            textFieldContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        // Text field
        textFieldContainer.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.placeholder = fieldPlaceholder
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(updateStrengthViews), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor, constant: textFieldMargin),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin)
        ])
        
        // Show/Hide button
        textFieldContainer.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: eyesClosedImage), for: .normal)
        showHideButton.setTitleColor(labelTextColor, for: .normal)
        showHideButton.addTarget(self, action: #selector(toggleShowPassword), for: .touchUpInside)
        
        // prevent expansion/compression of button when long password is entered and then deleted
        let horizontalExpansionResistance = showHideButton.contentHuggingPriority(for: .horizontal) + 1
        showHideButton.setContentHuggingPriority(horizontalExpansionResistance, for: .horizontal)
        let horizontalCompressionResistance = showHideButton.contentCompressionResistancePriority(for: .horizontal) + 1
        showHideButton.setContentCompressionResistancePriority(horizontalCompressionResistance, for: .horizontal)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            showHideButton.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin),
        ])
        
        // Strength color views
        for strength in strengths {
            guard let thisView = strength.value.view else { continue }
            let i = strength.key.rawValue
            thisView.backgroundColor = strengths[.none]?.color
            thisView.layer.cornerRadius = strengthViewRadius
            var leadingConstraintAnchor: NSLayoutXAxisAnchor
            var leadingMargin: CGFloat
            if i == 1 {
                leadingConstraintAnchor = leadingAnchor
                leadingMargin = standardMargin
            } else {
                guard let previousStrength = RelativePasswordStrength(rawValue: i - 1),
                    let previousStrengthView = strengths[previousStrength]?.view
                    else { continue }
                leadingConstraintAnchor = previousStrengthView.trailingAnchor
                leadingMargin = textFieldMargin
            }
            
            NSLayoutConstraint.activate([
                thisView.centerYAnchor.constraint(equalTo: strengthDescriptionLabel.centerYAnchor),
                thisView.leadingAnchor.constraint(equalTo: leadingConstraintAnchor, constant: leadingMargin),
                thisView.widthAnchor.constraint(equalToConstant: strengthViewSize.width),
                thisView.heightAnchor.constraint(equalToConstant: strengthViewSize.height),
            ])
        }
        
        // Strength text
        strengthDescriptionLabel.text = strengths[currentRelativeStrength]?.text
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strengths[.strong]!.view!.trailingAnchor, constant: standardMargin)
        ])
        
        // Constrain master view height
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor, constant: standardMargin)
        ])
    }
    
    // MARK: - Touch Handlers
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        sendActions(for: [.touchDown])
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if bounds.contains(touch.location(in: self)) {
            sendActions(for: [.touchDragInside])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        if bounds.contains(touch.location(in: self)) {
            sendActions(for: [.touchUpInside])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }

    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
    
    // MARK: - Update Methods

    @objc private func updateStrengthViews() {
        strengthDescriptionLabel.text = strengths[currentRelativeStrength]?.text
        
        strengths.forEach { (this) in
            let strength = this.value
            if currentRelativeStrength.rawValue >= this.key.rawValue {
                strength.view?.backgroundColor = strength.color
            } else {
                strength.view?.backgroundColor = strengths[.none]?.color
            }
        }
        if let strengthView = strengths[currentRelativeStrength]?.view {
            animateStrength(for: strengthView)
        }
    }
    
    private func animateStrength(for strengthView: UIView) {
        let growToShrinkTimingRatio = 0.05
        let yScaleFactor: CGFloat = 1.9
        let totalDuration = 0.8
        
        UIView.animateKeyframes(withDuration: totalDuration, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: growToShrinkTimingRatio) {
                strengthView.transform = CGAffineTransform(scaleX: 1, y: yScaleFactor)
            }
            UIView.addKeyframe(withRelativeStartTime: growToShrinkTimingRatio, relativeDuration: 1 - growToShrinkTimingRatio) {
                strengthView.transform = .identity
            }
        }, completion: nil)
    }
    
    @objc private func toggleShowPassword() {
        showingPassword.toggle()
        textField.isSecureTextEntry = !showingPassword
        let showHideImage = showingPassword ? eyesOpenImage : eyesClosedImage
        showHideButton.setImage(UIImage(named: showHideImage), for: .normal)
    }
    
    func determineStrength(of password: String) {
        var newStrength: RelativePasswordStrength = .none
        for strength in RelativePasswordStrength.allCases {
            if password.count >= strengths[strength]!.minChars {
                newStrength = strength
            }
        }
        
        if newStrength != currentRelativeStrength {
            currentRelativeStrength = newStrength
        }
    }
}

// MARK: - Text Field Delegate

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        determineStrength(of: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendActions(for: .valueChanged)
        return true
    }
}
