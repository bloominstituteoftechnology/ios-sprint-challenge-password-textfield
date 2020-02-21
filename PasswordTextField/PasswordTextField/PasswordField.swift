//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum PasswordState: String {
    case weak = "Too Weak"
    case medium = "Could be Stronger"
    case strong = "Very Strong"
    
}


 class PasswordField: UIControl  {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    
    
    //MARK: - Initialization
    
   override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setup()
     }
    
 //MARK: - Properties
    
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "ENTER PASSWORD"
        lb.font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
        return lb
    }()
   
    private var textField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .bezel
        textField.layer.borderWidth = 5.0
        textField.placeholder = "Enter password here..."
        textField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.layer.borderColor = ColorHelper.textFieldBorderColor.cgColor
        
        return textField
    }()
    
  
    private var showHideButton: UIButton = {
        let eyeButton = UIButton()
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(#imageLiteral(resourceName: "eyes-closed") , for: .normal)
        
        eyeButton.isUserInteractionEnabled = true
        eyeButton.addTarget(self, action: #selector(handleEye), for: .touchUpInside)
        return eyeButton
    }()
    
    @objc  func handleEye() {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            sendActions(for: .touchUpInside)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            sendActions(for: .touchUpInside)
        }
    }
    
    
    
    
    private var weakView: UIView = {
       let weak = UIView()
        weak.translatesAutoresizingMaskIntoConstraints = false
        weak.backgroundColor = ColorHelper.unusedColor
         weak.frame.size = CGSize(width: 60.0, height: 5.0)
        return weak
    }()
    private var mediumView: UIView = {
        let medium = UIView()
        medium.translatesAutoresizingMaskIntoConstraints = false
        medium.backgroundColor = ColorHelper.unusedColor
        medium.frame.size = CGSize(width: 60.0, height: 5.0)
        return medium
    }()
    private var strongView: UIView = {
       let strong = UIView()
        strong.translatesAutoresizingMaskIntoConstraints = false
        strong.backgroundColor = ColorHelper.unusedColor
         strong.frame.size = CGSize(width: 60.0, height: 5.0)
        return strong
    }()
    
     public var strengthDescriptionLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Weak"
        lb.numberOfLines = 0
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.textAlignment = .left
        return lb
    }()
    
    private var colorStackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
          stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
   // MARK: - Setup Subviews Function
    
    
  fileprivate func setup() {
        // Lay out your subviews here
      
        // Enter password Label
         addSubview(titleLabel)
         addSubview(showHideButton)
       
    // Textfield and eye button
         addSubview(textField)
         textField.addSubview(showHideButton)
         textField.delegate = self
    
    
      
        addSubview(weakView)
        addSubview(strongView)
        addSubview(mediumView)
        
    
        addSubview(colorStackView)
     
        // Weak, medium, strong Stackview
        colorStackView.addArrangedSubview(weakView)
        colorStackView.addArrangedSubview(mediumView)
        colorStackView.addArrangedSubview(strongView)
     
    // Stregth description label
        addSubview(strengthDescriptionLabel)
        showHideButton.center = textField.center
     
    // Constraint everything
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -16),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            colorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorStackView.widthAnchor.constraint(equalToConstant: 200),
            colorStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            colorStackView.heightAnchor.constraint(equalToConstant: 3),
            
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: colorStackView.trailingAnchor, constant: 30),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: colorStackView.bottomAnchor),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10)
        ])
    
    }

   public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
           return true
       }

    
}

// MARK: - TextField Handling




extension PasswordField: UITextFieldDelegate {
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        sendActions(for: .valueChanged)
   
        switch newText.count {
        case 0...9:
            strengthDescriptionLabel.text = PasswordState.weak.rawValue
            weakView.backgroundColor = ColorHelper.weakColor
            mediumView.backgroundColor = ColorHelper.unusedColor
            strongView.backgroundColor = ColorHelper.unusedColor
            if newText.count == 1 {
                 weakView.performFlare()
            }
           
        case 10...19:
            strengthDescriptionLabel.text = PasswordState.medium.rawValue
            weakView.backgroundColor = ColorHelper.weakColor
            mediumView.backgroundColor = ColorHelper.mediumColor
            strongView.backgroundColor = ColorHelper.unusedColor
            if newText.count == 10 {
                    mediumView.performFlare()
            }
        case 20...:
            strengthDescriptionLabel.text = PasswordState.strong.rawValue
            weakView.backgroundColor = ColorHelper.weakColor
            mediumView.backgroundColor = ColorHelper.mediumColor
            strongView.backgroundColor = ColorHelper.strongColor
            if newText.count == 21 {
                  strongView.performFlare()
            }
        default:
            break
        }
      
        return true
    }
}

extension UIView {
  
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
