//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength: String {
    case weak = "Weak"
    case medium = "Medium"
    case strong = "Strong"
}

@IBDesignable
class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var strength: PasswordStrength = .weak
    private var isPasswordShown = false
    
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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ENTER PASSWORD"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
        return label
    }()
    private lazy var textField: PasswordTextField = {
        let tf = PasswordTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 5
        tf.isSecureTextEntry = true
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(-8, 0, 0)
        tf.delegate = self
        return tf
    }()
    private var showHideButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleShowPasswordTapped), for: .touchUpInside)
        return button
    }()
    private var weakView: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var mediumView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var strongView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var strengthDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8.0, weight: .semibold)
        label.text = "Too Weak"
        label.textColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
        return label
    }()
    
    func setup() {
        // Lay out your subviews here
        
        backgroundColor = bgColor
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        addSubview(textField)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        textField.rightView = showHideButton
        textField.rightViewMode = .always
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        addSubview(weakView)
        weakView.backgroundColor = unusedColor
        addSubview(mediumView)
        mediumView.backgroundColor = unusedColor
        addSubview(strongView)
        strongView.backgroundColor = unusedColor
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            weakView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            weakView.heightAnchor.constraint(equalToConstant: 5),
            weakView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 4),
            mediumView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            mediumView.heightAnchor.constraint(equalToConstant: 5),
            mediumView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 4),
            strongView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            strongView.heightAnchor.constraint(equalToConstant: 5),
            strongView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        
        addSubview(strengthDescriptionLabel)
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: 8),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func handleShowPasswordTapped() {
        if isPasswordShown {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            isPasswordShown = false
        } else {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            isPasswordShown = true
        }
    }
    
    func determinePasswordStrength(for password: String) {
        if password.count <= 6 {
            strength = .weak
            strengthDescriptionLabel.text = "Too Weak"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            UIView.animate(withDuration: 1, animations: {
                self.weakView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            }) { _ in
                UIView.animate(withDuration: 1) {
                    self.weakView.transform = .identity
                }
            }
        } else if password.count <= 10 && password.count > 6 {
            strength = .medium
            strengthDescriptionLabel.text = "Could Be Stronger"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            
            UIView.animate(withDuration: 1, animations: {
                self.weakView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                self.mediumView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            }) { _ in
                UIView.animate(withDuration: 1) {
                    self.weakView.transform = .identity
                    self.mediumView.transform = .identity
                }
            }
        } else {
            strength = .strong
            strengthDescriptionLabel.text = "Strong Password"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            
            UIView.animate(withDuration: 1, animations: {
                self.weakView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                self.mediumView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                self.strongView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            }) { _ in
                self.weakView.transform = .identity
                self.mediumView.transform = .identity
                self.strongView.transform = .identity
            }
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        determinePasswordStrength(for: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        password = text
        sendActions(for: [.valueChanged])
        return true
    }
}
