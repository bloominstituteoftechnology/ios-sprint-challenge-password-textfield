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
    
   private func createView(viewColor : UIColor) -> UIView {
      let view = UIView()
    view.backgroundColor = viewColor
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }
    
    
    private var showHideButton: UIButton = {
        let eyeButton = UIButton()
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(#imageLiteral(resourceName: "eyes-open") , for: .normal)
        return eyeButton
    }()
    
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    
    private var strengthDescriptionLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Password is too weak"
        return lb
    }()
    
    var stateStackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    func setup() {
        // Lay out your subviews here
       let weak = createView(viewColor: ColorHelper.weakColor)
       let medium =  createView(viewColor: ColorHelper.mediumColor)
        let strong = createView(viewColor: ColorHelper.strongColor)
        
     
        backgroundColor = .gray
        
        addSubview(titleLabel)
         addSubview(textField)
         textField.addSubview(showHideButton)
         addSubview(stateStackView)
        
        stateStackView.addArrangedSubview(weak)
        stateStackView.addArrangedSubview(medium)
        stateStackView.addArrangedSubview(strong)
        
        showHideButton.center = textField.center
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
         
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -16),
           
            
            stateStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stateStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
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
