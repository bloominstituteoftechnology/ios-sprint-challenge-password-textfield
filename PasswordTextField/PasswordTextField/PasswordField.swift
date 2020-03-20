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
    
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        
        
        // title
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: standardMargin).isActive = true
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        // text field
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 8.0
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.becomeFirstResponder()
//        textField.isUserInteractionEnabled = true
        textField.textAlignment = .left
        textField.isSecureTextEntry = true
        textField.backgroundColor = bgColor
        
        // show/hide button
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10.0).isActive = true
        showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: textFieldContainerHeight / 4).isActive = true
        showHideButton.adjustsImageWhenDisabled = true
         let noShowImage = UIImage(named: "eyes-closed")
        showHideButton.setImage(noShowImage, for: .normal)
//        let showImage = UIImage(named: "eyes-open")
//        showHideButton.setImage(showImage, for: .selected)
//        showHideButton.setImage(noShowImage, for: .disabled)
        
        // weak view
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
//        weakView.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
        let offset = CGFloat(8.0)
        let weakViewOrigin = CGPoint(x: offset, y: 100.0)
        weakView.frame = CGRect(origin: weakViewOrigin, size: colorViewSize)
        weakView.backgroundColor = weakColor
        
        // medium view
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = true
//        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 6.0).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        mediumView.backgroundColor = mediumColor
        
        // strong view
        
        
        //strength label
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func updateShowHideButton(at touch: UITouch) {
        let touchPoint = touch.location(in: showHideButton)
        
        
    }
// tracking functions or toggle option for button??
    // Start tracking touch in control
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    
      return true
    }
    
    // End tracking touch in control
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
      guard let touch = touch else {
        NSLog("Unable to track touch")
        return
      }
      
      let touchPoint = touch.location(in: showHideButton)
      if bounds.contains(touchPoint) {
        
        sendActions(for: .touchUpInside)
      } else {
        sendActions(for: .touchUpOutside)
      }
    }
    
    // Cancel tracking
    override func cancelTracking(with event: UIEvent?) {
      sendActions(for: .touchCancel)
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
