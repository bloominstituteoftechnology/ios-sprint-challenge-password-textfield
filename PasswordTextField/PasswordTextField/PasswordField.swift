//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import Foundation

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
    
    private var isTextHidden: Bool = false
    //private var showHideImage: UIImage = UIImage()
    //private var currentStrength: Strength = .we
    
    
//    override func draw(_ rect: CGRect) {
//        
//        if let context = UIGraphicsGetCurrentContext() {
//            
//            let passwordBorder = CGRect(x: frame.minX / 2 - bounds.minX / 2, y: titleLabel.bounds.maxY + 10, width:  250, height: textFieldContainerHeight)
//            
//            
//            context.addEllipse(in: passwordBorder)
//            context.setStrokeColor(textFieldBorderColor.cgColor)
//            
//            context.strokePath()
//        }
//    }
    
    func setup() {
        // Lay out your subviews here
        backgroundColor = bgColor
        
        // Enter password Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Pasword: "
        titleLabel.textAlignment = .left
        titleLabel.font = labelFont
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
        ])
        
        let containerView = UIView()
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        containerView.layer.borderColor = textFieldBorderColor.cgColor
        containerView.layer.borderWidth = 2.0
        containerView.layer.cornerRadius = 5.0
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            containerView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        ])
        
        containerView.addSubview(textField)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = textFieldBorderColor
        textField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: textFieldMargin),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: textFieldMargin),
            containerView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: textFieldMargin)
        ])
        
        containerView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        
        NSLayoutConstraint.activate([
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            containerView.trailingAnchor.constraint(equalTo: showHideButton.trailingAnchor, constant: textFieldMargin)
        ])
        
        showHideButton.addTarget(self, action: #selector(changeImage(_:)), for: .touchUpInside)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.backgroundColor = weakColor
        
        NSLayoutConstraint.activate([
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        mediumView.layer.cornerRadius = colorViewSize.height / 2.0
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.backgroundColor = mediumColor
        NSLayoutConstraint.activate([
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        mediumView.layer.cornerRadius = colorViewSize.height / 2.0
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.backgroundColor = strongColor
        
        NSLayoutConstraint.activate([
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        strongView.layer.cornerRadius = colorViewSize.height / 2.0
        
        let colorStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        
        addSubview(colorStackView)
        colorStackView.translatesAutoresizingMaskIntoConstraints = false
        
        colorStackView.axis = .horizontal
        colorStackView.alignment = .fill
        colorStackView.distribution = .fill
        colorStackView.spacing = 2.0
        
        NSLayoutConstraint.activate([
            colorStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 15.0),
            colorStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: colorStackView.trailingAnchor, constant: standardMargin),
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: colorStackView.centerYAnchor),
            bottomAnchor.constraint(equalTo: strengthDescriptionLabel.bottomAnchor, constant: standardMargin)
        ])
        
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
//
//        //Strength views
//        addSubview(weakView)
//        weakView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
//            weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            //weakView.
//
//
//
//        ])
//
        
//        
//        textField.addTarget(ViewController, action: #selector(textFieldEditingChanged(_:)), for: UIControlEvents.editingChanged)
//        
//        
        
        
        
        
        
        
        func determinePasswordStrength(string: String) {
            var strength = Strength.weak
            
            // Changing currentStrength and strengthLabel based on password strength
            switch string.count {
            case 1...9 :
                strength = .weak
            case 10...19 :
                strength = .medium
            default :
                strength = .strong
            }
        }
        
        
    }
    
    @objc func changeImage(_ sender: UIButton) {
        isTextHidden.toggle()
        
        showHideButton.setImage(UIImage(named: (isTextHidden) ? "eyes-open" : "eyes-closed"), for: .normal)
        textField.isSecureTextEntry.toggle()

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
        
        
        
        // TODO: send new text to the determine strength method
        
        
        return true
    }
    
    // TODO ShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    
}

enum Strength: Int {
    case weak = 1
    case medium
    case strong
}
