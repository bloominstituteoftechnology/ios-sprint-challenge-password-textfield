//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private var isTextHidden = true
    
    enum PasswordStrength: String {
        case bad = "Too weak"
        case ok = "Could be stronger"
        case good = "Strong password"
    }
    
    private var previousStrength: PasswordStrength = .bad
    public private (set) var strength: PasswordStrength = .bad
    public private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton(type: .custom)
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        textField.delegate = self
        // Lay out your subviews here
        setupTitleLabel()
        setupTextField()
        setupShowHideButton()
        setupViews()
        setupStrengthLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //Setting strength and the views color
    func determineStrength(text: String) {
        switch text.count {
        case 0...9:
            strength = .bad
            strongView.backgroundColor = .gray
            mediumView.backgroundColor = .gray
            weakView.backgroundColor = .red
        case 10...19:
            strength = .ok
            strongView.backgroundColor = .gray
            mediumView.backgroundColor = .orange
            weakView.backgroundColor = .red
            
        case 20...:
            strength = .good
            strongView.backgroundColor = .green
            mediumView.backgroundColor = .orange
            weakView.backgroundColor = .red
        default:
            strength = .good
            strongView.backgroundColor = .green
            mediumView.backgroundColor = .orange
            weakView.backgroundColor = .red

        }
        
        strengthDescriptionLabel.text = strength.rawValue
    }
    
    //MARK: - Actions
    @objc func textFieldEdited() {
        guard let text = textField.text else { return }
        determineStrength(text: text)
        password = text
        
        if previousStrength != strength {
            animate()
            previousStrength = strength
        }
    }
    
    @objc func buttonPressed() {
        if isTextHidden == true {
            guard let image = UIImage(named: "eyes-open") else { return }
            showHideButton.setImage(image, for: .normal)
            textField.isSecureTextEntry = false
            isTextHidden = false
        } else {
            guard let image = UIImage(named: "eyes-closed") else { return }
            showHideButton.setImage(image, for: .normal)
            textField.isSecureTextEntry = true
            isTextHidden = true
        }
    }
    
    func animate() {
        var n = 0
        switch strength {
        case .bad:
            n = 0
        case .ok:
            n = 1
        case .good:
            n = 2
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2) {
                switch n {
                case 0:
                    self.weakView.frame.size = CGSize(width: self.colorViewSize.width + 15.0, height: 15.0)
                case 1:
                    self.mediumView.frame.size = CGSize(width: self.colorViewSize.width + 15.0, height: 15.0)
                    break
                case 2:
                    self.strongView.frame.size = CGSize(width: self.colorViewSize.width + 15.0, height: 15.0)
                    break
                default:
                    break
                }
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 1.0) {
                switch n {
                case 0:
                    self.weakView.frame.size = CGSize(width: self.colorViewSize.width + 15.0, height: 7.0)
                case 1:
                    self.mediumView.frame.size = CGSize(width: self.colorViewSize.width + 15.0, height: 7.0)
                    break
                case 2:
                    self.strongView.frame.size = CGSize(width: self.colorViewSize.width + 15.0, height: 7.0)
                    break
                default:
                    break
                }
            }
            
            
        }, completion: nil)
    }
}

//MARK: - Added Text Field Delegate
extension PasswordField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendActions(for: [.valueChanged])
        return true
    }
}


//MARK: - Setting Up Objects
extension PasswordField {
    func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)])
        
    }
    
    func setupTextField() {
        textField.font = .systemFont(ofSize: 24, weight: .medium)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.5, constant: 0.0)
            ])
    }
    
    func setupShowHideButton() {
    
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        guard let image = UIImage(named: "eyes-closed") else {
            return
        }
        showHideButton.isUserInteractionEnabled = true
        showHideButton.setImage(image, for: .normal)
        showHideButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: showHideButton, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: showHideButton, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .trailing, multiplier: 1.0, constant: -10.0)])
    }
    
    func setupViews() {
        weakView.backgroundColor = .red
        mediumView.backgroundColor = .gray
        strongView.backgroundColor = .gray
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.frame.size = colorViewSize
        mediumView.frame.size = colorViewSize
        strongView.frame.size = colorViewSize
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: weakView, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: weakView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: weakView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.20, constant: 0.0),
            NSLayoutConstraint(item: weakView, attribute: .height, relatedBy: .equal, toItem: textField, attribute: .height, multiplier: 0.25, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: mediumView, attribute: .top, relatedBy: .equal, toItem: weakView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: mediumView, attribute: .leading, relatedBy: .equal, toItem: weakView, attribute: .trailing, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: mediumView, attribute: .width, relatedBy: .equal, toItem: weakView, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: mediumView, attribute: .height, relatedBy: .equal, toItem: weakView, attribute: .height, multiplier: 1.0, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: strongView, attribute: .top, relatedBy: .equal, toItem: mediumView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: strongView, attribute: .leading, relatedBy: .equal, toItem: mediumView, attribute: .trailing, multiplier: 1.0, constant: 5.0),
            NSLayoutConstraint(item: strongView, attribute: .width, relatedBy: .equal, toItem: mediumView, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: strongView, attribute: .height, relatedBy: .equal, toItem: mediumView, attribute: .height, multiplier: 1.0, constant: 0.0)
        ])
    }
    
    func setupStrengthLabel() {
        strengthDescriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        strengthDescriptionLabel.text = strength.rawValue
        strengthDescriptionLabel.textColor = .black
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .top, relatedBy: .equal, toItem: strongView, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: strengthDescriptionLabel, attribute: .leading, relatedBy: .equal, toItem: strongView, attribute: .trailing, multiplier: 1.0, constant: 5.0)
        ])
    }
}
