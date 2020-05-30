//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}

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
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    
    func setup() {
        // Lay out your subviews here
        
        //Title Label
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        
        //Text field
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1).isActive = true
        textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.borderStyle = .bezel
        textField.isUserInteractionEnabled = true
        textField.textAlignment = .left
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.layer.borderColor = textFieldBorderColor.cgColor
        self.textField.delegate = self
        textField.placeholder = "Enter password here"
        
        //password strength label
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2).isActive = true
        strengthDescriptionLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        
        
        //show hide button
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setBackgroundImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.setBackgroundImage(UIImage(named: "eyes-open"), for: .disabled)
        showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        showHideButton.rightAnchor.constraint(equalTo: textField.rightAnchor, constant: -10).isActive = true
        
        //Strength Views
        addSubview(weakView)
        weakView.backgroundColor = weakColor
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.frame.size.height = 5
        weakView.frame.size.width = 50
        weakView.frame.origin.x = 10
        weakView.frame.origin.y = 95
        weakView.bringSubviewToFront(self)
        
        addSubview(mediumView)
        mediumView.backgroundColor = unusedColor
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.frame.size.height = 5
        mediumView.frame.size.width = 50
        mediumView.frame.origin.x = 70
        mediumView.frame.origin.y = 95
        mediumView.bringSubviewToFront(self)
        
        addSubview(strongView)
        strongView.backgroundColor = unusedColor
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.frame.size.height = 5
        strongView.frame.size.width = 50
        strongView.frame.origin.x = 130
        strongView.frame.origin.y = 95
        strongView.bringSubviewToFront(self)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func determineStrength(with password: String) {
        let strength = password.count
        
        if strength <= 9 {
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            weakView.performFlare()
        } else if strength > 9 && strength <= 19 {
            strongView.backgroundColor = unusedColor
            mediumView.backgroundColor = mediumColor
            mediumView.performFlare()
        } else if strength > 19 {
            strongView.backgroundColor = strongColor
            strongView.performFlare()
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        determineStrength(with: newText)
        return true
    }
}
