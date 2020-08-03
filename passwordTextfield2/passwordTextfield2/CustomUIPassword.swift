//
//  CustomUIPassword.swift
//  passwordTextfield2
//
//  Created by Clean Mac on 8/2/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit
import SwiftUI

class CustomUIPassword: UIControl {
    
    // SETUP SUB VIEWS
    private lazy var enterPasswordLabel: UILabel = {
        let enterPasswordLabel = UILabel()
        enterPasswordLabel.text = "ENTER PASSWORD"
        return enterPasswordLabel
    }()
    
    private lazy var inputPasswordField: UITextField = {
        let inputPasswordField = UITextField()
        inputPasswordField.placeholder = "enter password here"
        inputPasswordField.autocapitalizationType = .none
        // DELEGATE? inputPasswordField.delegate = self
        
        return inputPasswordField
    }()
    
    private lazy var weakView: UIView = {
        let weakView = UIView()
        weakView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        weakView.layer.cornerRadius = 2
        weakView.frame = CGRect(x: 8, y: self.bounds.size.height, width: 50, height: 5)
        return weakView
    }()
    private lazy var mediumView: UIView = {
        let mediumView = UIView()
        mediumView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        mediumView.layer.cornerRadius = 2
        mediumView.frame = CGRect(x: 8, y: self.bounds.size.height, width: 50, height: 5)
        return mediumView
    }()
    private lazy var strongView: UIView = {
        let strongView = UIView()
        strongView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        strongView.layer.cornerRadius = 2
        strongView.frame = CGRect(x: 8, y: self.bounds.size.height, width: 50, height: 5)
        return strongView
    }()
    
//    private lazy var passwordStrengthLabel: UILabel = {
//        let passwordStrengthStrengthLabel = UILabel()
//        passwordStrengthLabel.text = "Weak"
//        return passwordStrengthLabel
//    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    private func setUpViews() {
        // TODO: Add views and configure constraints
        //Horizontal stack view for strength view and label
        let strengthStack = UIStackView(arrangedSubviews: [weakView, mediumView, strongView ])
        strengthStack.alignment = .center
        strengthStack.spacing = 20
        // main stack view to put password textfield,  strength stack
        let mainStack = UIStackView(arrangedSubviews: [
            enterPasswordLabel,
            inputPasswordField,
            strengthStack
        ])
        
        mainStack.axis = .vertical
        mainStack.alignment = .leading
        mainStack.distribution = .fillEqually
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        // add main stack view to this view and add constraints
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            enterPasswordLabel.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            inputPasswordField.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
    
}
