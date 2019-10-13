//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

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
    
    private var isTextHidden: Bool = true
    private var showHideImage: UIImage = UIImage()
    private var currentStrength: Strength = .weak
    private var strengthLabel: Strength.RawValue = "Too weak"
    
    
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
        
        // Password TextField
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = false
        textField.isEnabled = true
        
        
        
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor), //I might need a constant
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //show/hide button
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.imageView?.image = changeImage()
        
         NSLayoutConstraint.activate([
                   showHideButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor), //I might need a constant
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 5),
                   showHideButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                   showHideButton.heightAnchor.constraint(equalToConstant: 40)
               ])
        
        //Strength views
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        
        
        
        ])
        
        
//        
//        textField.addTarget(ViewController, action: #selector(textFieldEditingChanged(_:)), for: UIControlEvents.editingChanged)
//        
//        
        
        
        
        
        
        
        
        
        
    }
    
    private func changeImage() -> UIImage {
        if isTextHidden == true {
            showHideImage = UIImage(named: "eyes-closed")!
            return showHideImage
        } else {
            showHideImage = UIImage(named: "eyes-open")!
            return showHideImage
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
        
        
        
        // TODO: send new text to the determine strength method
        
        // Changing currentStrength and strengthLabel based on password strength
        switch newText.count {
        case 1...9 :
            currentStrength = .weak
            strengthLabel = Strength.weak.rawValue
        case 10...19 :
            currentStrength = .medium
            strengthLabel = Strength.medium.rawValue
        case 20...200 :
            currentStrength = .strong
            strengthLabel = Strength.strong.rawValue
        default:
            print( "Password entered ether has no characters, or ismore than 200 characters long")
        }
        
        return true
    }
    
    // TODO ShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

enum Strength: String {
    case weak = "Too Weak"
    case medium = "Coukd be Stronger"
    case strong = "Strong Password"
}
