//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum StrengthColor: String {
    case no = "No Password"
    case weak = "Weak Password"
    case medium = "Medium Password"
    case strong = "Strong Password"
}

class PasswordField: UIControl {

    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = "" {
        didSet {
            recognisePassStr()
            
        }
    }
    
    private (set) var passStrength: StrengthColor? {
              didSet {
                  changePassStrBarColor()
              }
          }
    
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
    //Set up Text fields + stackViews
    private var textFieldView: UIView = UIView()
    private var strengthBarHorizontalView: UIStackView = UIStackView()
    private var everythingElseStack: UIStackView = UIStackView()
    
    func setup() {
        // Lay out your subviews here -
        layer.cornerRadius = 6
        backgroundColor = bgColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
       
        [titleLabel, textField, strengthBarHorizontalView].forEach {
          everythingElseStack.addArrangedSubview($0)
        }
        [weakView, mediumView, strongView, strengthDescriptionLabel].forEach {
            strengthBarHorizontalView.addArrangedSubview($0)
        }
        
    // MARK: - Label Setup
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
    // MARK: - TextField Setup
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.rightView = showHideButton
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        // MARK: - Sizing + Spacing
        textFieldView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        everythingElseStack.alignment = .fill
        everythingElseStack.distribution = .fill
        everythingElseStack.axis = .vertical
        strengthBarHorizontalView.alignment = .center
        strengthBarHorizontalView.distribution = .fill
        strengthBarHorizontalView.spacing = standardMargin

        // Stack Views
        everythingElseStack.spacing = standardMargin
        [everythingElseStack].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        strengthDescriptionLabel.text = "Strength Indicator"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor

        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 0, y: 0, width: 50, height: 38)
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        showHideButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
    
    // different strengths set ups:
    
    // MARK: - WeakView Setup
          weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
          weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
          weakView.layer.cornerRadius = colorViewSize.height / 2

          // MARK: - MediumView Setup
          mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
          mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
          mediumView.layer.cornerRadius = colorViewSize.height / 2

          // MARK: - StrongView Setup
          strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
          strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
          strongView.layer.cornerRadius = colorViewSize.height / 2
         
          // MARK: - StackViews Constraints
        everythingElseStack.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        everythingElseStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -standardMargin).isActive = true
        everythingElseStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        everythingElseStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        strengthBarHorizontalView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Helper Functions
    
    //Changes color when typing in password
    func changePassStrBarColor() {
        if let passStrength = passStrength,
            let password = textField.text,
            !password.isEmpty {
            switch passStrength {
            case .no:
                weakView.backgroundColor = unusedColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passStrength.rawValue
            case .weak:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passStrength.rawValue
                weakView.performFlare()
            case .medium:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = mediumColor
                strongView.backgroundColor = unusedColor
                strengthDescriptionLabel.text = passStrength.rawValue
                mediumView.performFlare()
            case .strong:
                weakView.backgroundColor = weakColor
                mediumView.backgroundColor = mediumColor
                strongView.backgroundColor = strongColor
                strengthDescriptionLabel.text = passStrength.rawValue
                strongView.performFlare()
            }
        } else {
            weakView.backgroundColor = unusedColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        }
    }

    func recognisePassStr() {
        if password.count == 0 {
            passStrength = .no
        } else if password.count < 5 {
            passStrength = .weak
        } else if (5...10).contains(password.count) {
            passStrength = .medium
        } else {
            passStrength = .strong
        }
    }
    
    @objc func showPassword() {
    switch textField.isSecureTextEntry {
            case true:
                textField.isSecureTextEntry = false
                showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            case false:
                textField.isSecureTextEntry = true
                showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
        func springAnimationWeak() {
            weakView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                self.weakView.transform = .identity
            }, completion: nil)
        }
        func springAnimationMedium() {
            mediumView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                self.mediumView.transform = .identity
            }, completion: nil)
        }
        func springAnimationStrong() {
            strongView.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                self.strongView.transform = .identity
            }, completion: nil)
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let newPass = textField.text {
                password = newPass
                sendActions(for: .valueChanged)
            }
            weakView.performFlare()
            mediumView.performFlare()
            strongView.performFlare()
            textField.resignFirstResponder()
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let textField = textField.text {
                password = textField
                sendActions(for: .valueChanged)
            }
        }
    }

extension UIView {
    func performFlare() {
        func flare() { transform = CGAffineTransform(scaleX: 1, y: 1.8) }
            func unflare() { transform = .identity }
            
         UIView.animate(withDuration: 0.5, animations: { flare() },
            completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
