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
    private (set) var relativeStrength: RelativePasswordStrength = .none {
        didSet {
            updateStrengthViews()
        }
    }
    
    // MARK: - Subview Settings
    private let standardMargin: CGFloat = 8.0
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
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    // Subviews
    private var titleLabel: UILabel = UILabel()
    private var textFieldContainer: UIView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthViews: [UIView] = []
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
//            textField,
//            showHideButton, // these will be added as subviews of textFieldContainer
            weakView,
            mediumView,
            strongView,
            strengthDescriptionLabel
        ].forEach { (view) in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
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
        textField.placeholder = fieldPlaceholder
        textField.delegate = self
        textField.addTarget(self, action: #selector(passwordChanged), for: .valueChanged)
//        textField.borderStyle = .roundedRect
//        textField.layer.borderColor = textFieldBorderColor.cgColor
//        textField.layer.borderWidth = textFieldBorderWidth
//        textField.backgroundColor = bgColor
//        NSLayoutConstraint.activate([
//            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
//            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textFieldMargin),
//            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: textFieldMargin),
//            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
//        ])
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
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: textFieldMargin),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            showHideButton.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -textFieldMargin),
        ])
        
        // Strength views
        strengthViews = [weakView, mediumView, strongView]
        for i in 0..<strengthViews.count {
            let this = strengthViews[i]
            
            this.backgroundColor = unusedColor
            this.layer.cornerRadius = strengthViewRadius
            
            NSLayoutConstraint.activate([
                this.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin),
                this.leadingAnchor.constraint(
                    equalTo: i == 0 ? leadingAnchor : strengthViews[i-1].trailingAnchor,
                    constant: textFieldMargin),
                this.widthAnchor.constraint(equalToConstant: strengthViewSize.width),
                this.heightAnchor.constraint(equalToConstant: strengthViewSize.height),
            ])
        }
        
        // Strength text
        strengthDescriptionLabel.text = relativeStrength.rawValue
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin)
        ])
    }
    
    // MARK: - Touch Handlers
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        update(for: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if bounds.contains(touch.location(in: self)) {
            sendActions(for: [.touchDragInside])
            update(for: touch)
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        if bounds.contains(touch.location(in: self)) {
            sendActions(for: [.touchUpInside])
            update(for: touch)
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
    
    // MARK: - Update Methods
    
    private func update(for touch: UITouch) {
        if textField.bounds.contains(touch.location(in: textField)) {
            textField.becomeFirstResponder()
            print("yay")
        }
    }
    
    @objc func passwordChanged() {
        print("Password: " + password)
        print("Strength: \(relativeStrength) (\"\(relativeStrength.rawValue)\")")
    }
    
    private func updateStrengthViews() {
        strengthDescriptionLabel.text = relativeStrength.rawValue
        strengthViews.forEach { (view) in
            view.backgroundColor = unusedColor
        }
        switch relativeStrength {
        case .none:
            break
        case .weak:
            weakView.backgroundColor = weakColor
            animateStrength(for: weakView)
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            animateStrength(for: mediumView)
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            animateStrength(for: strongView)
        }
    }
    
    private func animateStrength(for strengthView: UIView) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                strengthView.transform = CGAffineTransform(scaleX: 1, y: 1.5)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                strengthView.transform = .identity
            }
        }, completion: nil)
    }
    
    enum RelativePasswordStrength: String {
        case none = ""
        case weak = "Too weak"
        case medium = "Could be stronger"
        case strong = "Strong password"
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        relativeStrength = determineStrength(of: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
    }
    
    func determineStrength(of password: String) -> RelativePasswordStrength {
        switch password.count {
        case 1...9:
            return .weak
        case 10...19:
            return .medium
        case let length where length >= 20:
            return .strong
        default:
            return .none
        }
    }
}
