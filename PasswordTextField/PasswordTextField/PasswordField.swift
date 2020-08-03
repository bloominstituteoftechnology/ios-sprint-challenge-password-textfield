//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//


import UIKit


enum PasswordStrength: String {
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}

class PasswordField: UIControl {
    
    
    private (set) var password: String = ""
    private (set) var passwordStrength: PasswordStrength = .weak
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
   
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
    
    private var passwordFieldStackView: UIStackView = UIStackView()
    private var passwordStrengthStackView: UIStackView = UIStackView()
    private var strengthColorsStackView: UIStackView = UIStackView()
        
    
    private func setup() {
      
        addSubview(passwordFieldStackView)
        passwordFieldStackView.axis = .vertical
        passwordFieldStackView.spacing = standardMargin
        passwordFieldStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            passwordFieldStackView.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            passwordFieldStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            passwordFieldStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])

        setupTitleLabel()
        setupTextField()
        setupPasswordStrengthViews()

        passwordFieldStackView.addArrangedSubview(titleLabel)
        passwordFieldStackView.addArrangedSubview(textField)
        passwordFieldStackView.addArrangedSubview(passwordStrengthStackView)
        
        backgroundColor = bgColor
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: passwordFieldStackView.heightAnchor, constant: standardMargin * 2)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
    }
    
    private func setupTextField() {
        
        // Setup Text Field
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 4.0
        textField.backgroundColor = bgColor
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(updatePassword), for: .valueChanged)

        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        let leftOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        textField.leftView = leftOverlayView
        textField.leftViewMode = UITextField.ViewMode.always
        
        let rightOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldContainerHeight + (textFieldMargin * 2), height: textFieldContainerHeight))
        
     
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 0, y: 0, width: textFieldContainerHeight, height: textFieldContainerHeight)
        showHideButton.imageView?.contentMode = .scaleAspectFit
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        rightOverlayView.addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: rightOverlayView.topAnchor),
            showHideButton.bottomAnchor.constraint(equalTo: rightOverlayView.bottomAnchor),
            showHideButton.leadingAnchor.constraint(equalTo: rightOverlayView.leadingAnchor, constant: textFieldMargin),
            showHideButton.trailingAnchor.constraint(equalTo: rightOverlayView.trailingAnchor, constant: -textFieldMargin),
        ])
        
        textField.rightView = rightOverlayView
        textField.rightViewMode = UITextField.ViewMode.always
    }
        
    private func setupPasswordStrengthViews() {
        
        // Password Strength StackView
        passwordStrengthStackView.axis = .horizontal
        passwordStrengthStackView.alignment = .center
        passwordStrengthStackView.spacing = standardMargin
        
        // Add Colors StackView
        setupColorsStackView()
        passwordStrengthStackView.addArrangedSubview(strengthColorsStackView)
        
        // Add Strength Description Label
        strengthDescriptionLabel.text = PasswordStrength.weak.rawValue
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        passwordStrengthStackView.addArrangedSubview(strengthDescriptionLabel)
    }
    
    private func setupColorsStackView() {
        strengthColorsStackView.translatesAutoresizingMaskIntoConstraints = false
        strengthColorsStackView.axis = .horizontal
        strengthColorsStackView.spacing = 2.0
        
        strengthColorsStackView.addArrangedSubview(weakView)
        strengthColorsStackView.addArrangedSubview(mediumView)
        strengthColorsStackView.addArrangedSubview(strongView)
        
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        for view in strengthColorsStackView.arrangedSubviews where ((view as? UILabel) == nil) {
            view.layer.cornerRadius = colorViewSize.height / 2.0
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: colorViewSize.width),
                view.heightAnchor.constraint(equalToConstant: colorViewSize.height)
            ])
        }
    }
    
    private func determineStrength(for password: String) {
        var newStrength: PasswordStrength
        
        switch password.count {
        case 0...5:
            newStrength = PasswordStrength.weak
        case 6...9:
            newStrength = PasswordStrength.medium
        default:
            newStrength = PasswordStrength.strong
        }
        
        if passwordStrength != newStrength {
            updatePasswordStrength(to: newStrength)
        }
    }
    
    private func updatePasswordStrength(to newStrength: PasswordStrength) {
        passwordStrength = newStrength
        strengthDescriptionLabel.text = passwordStrength.rawValue
        
        switch passwordStrength {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            weakView.performFlare()
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            mediumView.performFlare()
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strongView.performFlare()
        }
    }
    
    @objc func showHideButtonTapped() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    @objc func updatePassword() {
        guard let password = textField.text else {
            self.password = ""
            return
        }
        
        self.password = password
        textField.resignFirstResponder()
        sendActions(for: [.valueChanged])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        determineStrength(for: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updatePassword()
        return true
    }
}

extension UIView {
    
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.0, y: 1.5) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.25,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
