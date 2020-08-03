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
    //view
    private var titleLabel: UILabel = UILabel()
    //view
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    //view
    
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    //view
    
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    
    
    //all views
    func setupViews() {
        // Lay out your subviews here
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = .black
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Type password here"
        //textField.isHidden = true
        textField.backgroundColor = bgColor
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1
        textField.isUserInteractionEnabled = true
        
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        
        addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            showHideButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            showHideButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            showHideButton.heightAnchor.constraint(equalTo: widthAnchor)
        ])
        
        showHideButton.isUserInteractionEnabled = true
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.layer.cornerRadius = 12
        weakView.backgroundColor = weakColor
        
        addSubview(weakView)
        
        NSLayoutConstraint.activate([
            weakView.leadingAnchor.constraint(equalTo: leadingAnchor),
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            weakView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.layer.cornerRadius = 12
        mediumView.backgroundColor = mediumColor
        
        addSubview(mediumView)
        
        NSLayoutConstraint.activate([
            mediumView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            mediumView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.layer.cornerRadius = 12
        strongView.backgroundColor = strongColor
        
        addSubview(strongView)
        
        NSLayoutConstraint.activate([
            strongView.leadingAnchor.constraint(equalTo: leadingAnchor),
            strongView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            strongView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = ""
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}

//password change and animations

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        // TODO: send new text to the determine strength method
        //        if newText = newText {
        //
        //           } else if {
        //
        //           } else if {
        //
        //           }
        //
        
        
        return true
    }
    
    //animations
    
    @objc private func showHideButtonTapped() {
        
        let toggle = textField.isSecureTextEntry
        if toggle {
            textField.isSecureTextEntry = false
        } else {
            textField.isSecureTextEntry = true
        }
        
        //        let fade = {
        //            UIView.animate(withDuration: 0.25, delay: 0.15, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: [], animations: {
        //                self.showHideButton.alpha = 0
        //            })
        //            let eyesAppear = {
        //                UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: [], animations: {
        //                    self.showHideButton.alpha = 1
        //                })
        //            }
        //            UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: eyesAppear, completion: nil)
        //        }
        //        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: fade, completion: nil)
    }
    private func strengthDescriptionAnimate(_view: UIView) {
        
    }
}
