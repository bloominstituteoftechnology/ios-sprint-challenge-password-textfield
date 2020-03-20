//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum Strength: String {
    case none = "Enter password"
    case weak = "Too weak"
    case medium = "Could be stronger"
    case strong = "Strong password"
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = "" {
        didSet {
            checkTheStrength()
        }
    }
    
    private (set) var level: Strength = .none
    
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
    
    func checkTheStrength() {
        
        let numbers = password.count
        
        switch numbers {
        case 0...5:
            if level != .weak {
                weakView.backgroundColor = weakColor
                weakView.heighten()
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
                level = .weak
                strengthDescriptionLabel.text = level.rawValue
            }
        case 6...10:
            if level != .medium {
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = mediumColor
                mediumView.heighten()
                strongView.backgroundColor = unusedColor
                level = .medium
                strengthDescriptionLabel.text = level.rawValue
            }
        case 11...:
            if level != .strong {
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = mediumColor
                strongView.backgroundColor = strongColor
                strongView.heighten()
                level = .strong
                strengthDescriptionLabel.text = level.rawValue
            }
        default:
            break
        }
    }
    
    func setup() {
        
        textField.delegate = self
        
        let bgView = UIView()
        bgView.backgroundColor = bgColor
        bgView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bgView)
        
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: "eyes-closed") {
            showHideButton.setImage(image, for: .normal)
        }
        
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 3
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showHideButton.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        showHideButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 6.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        addSubview(textField)
        
        weakView.backgroundColor = unusedColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        mediumView.backgroundColor = unusedColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strongView.backgroundColor = unusedColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
    
        strengthDescriptionLabel.text = Strength.none.rawValue
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = UIFont.systemFont(ofSize: 12.0)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 1.0

        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: self.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 109),
            
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin),
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin),
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin),
        titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: textFieldMargin),
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        
        stackView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
        stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
        stackView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        stackView.widthAnchor.constraint(equalToConstant: 182),
        
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
        strengthDescriptionLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 6)
            
        ])
    }
    
    @objc private func toggleVisibility() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry == false {
            if let image = UIImage(named: "eyes-open") {
                showHideButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "eyes-closed") {
                showHideButton.setImage(image, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
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
        
        password = newText
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        sendActions(for: [.valueChanged])
        return true
    }
}

extension UIView {
    func heighten() {
        func goUp()   { transform = CGAffineTransform(scaleX: 1.1, y: 1.1) }
        func goDown() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { goUp() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { goDown() }})
    }
    
}
