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
    
  
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
   override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setup()
     }
    
 
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "ENTER PASSWORD"
        lb.font = .italicSystemFont(ofSize: 16)
        return lb
    }()
   
    private var textField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .bezel
        textField.layer.borderWidth = 5.0
        textField.placeholder = "Enter password"
        textField.becomeFirstResponder()
        textField.isSecureTextEntry = true
        textField.layer.borderColor = ColorHelper.textFieldBorderColor.cgColor
        
        return textField
    }()
    
  
    private var showHideButton: UIButton = {
        let eyeButton = UIButton()
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(#imageLiteral(resourceName: "eyes-open") , for: .normal)
        return eyeButton
    }()
    
    
    private var weakView: UIView = {
       let weak = UIView()
        weak.translatesAutoresizingMaskIntoConstraints = false
        weak.backgroundColor = ColorHelper.weakColor
         weak.frame.size = CGSize(width: 60.0, height: 5.0)
        return weak
    }()
    private var mediumView: UIView = {
        let medium = UIView()
        medium.translatesAutoresizingMaskIntoConstraints = false
        medium.backgroundColor = ColorHelper.mediumColor
        medium.frame.size = CGSize(width: 60.0, height: 5.0)
        return medium
    }()
    private var strongView: UIView = {
       let strong = UIView()
        strong.translatesAutoresizingMaskIntoConstraints = false
        strong.backgroundColor = ColorHelper.strongColor
         strong.frame.size = CGSize(width: 60.0, height: 5.0)
        return strong
    }()
    
    private var strengthDescriptionLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Strong Password"
        lb.numberOfLines = 0
        lb.textAlignment = .left
        return lb
    }()
    
    private var statusStackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
          stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
   
    
    func setup() {
        // Lay out your subviews here
      
        
        addSubview(titleLabel)
        
         addSubview(textField)
         textField.addSubview(showHideButton)
     
        
        addSubview(weakView)
        addSubview(strongView)
        addSubview(mediumView)
        
    
        addSubview(statusStackView)
     
        
        statusStackView.addArrangedSubview(weakView)
        statusStackView.addArrangedSubview(mediumView)
        statusStackView.addArrangedSubview(strongView)
     
    
        addSubview(strengthDescriptionLabel)
        showHideButton.center = textField.center
     
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -16),
            showHideButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            
            statusStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusStackView.widthAnchor.constraint(equalToConstant: 200),
            statusStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            statusStackView.heightAnchor.constraint(equalToConstant: 3),
            
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: statusStackView.trailingAnchor, constant: 30),
            strengthDescriptionLabel.bottomAnchor.constraint(equalTo: statusStackView.bottomAnchor),
            strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10)
        ])
    
    }
  
}













extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
//        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
