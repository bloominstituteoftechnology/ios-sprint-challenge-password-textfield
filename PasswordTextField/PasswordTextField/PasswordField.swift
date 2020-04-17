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
    var isTextHidden = true
    
    enum PasswordStrength: String {
        case bad = "Too weak"
        case ok = "Could be stronger"
        case good = "Strong password"
    }
    
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    //private let viewSize = CGRect(x: 0, y: 0, width: 50, height: 50)
    
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
    private var showHideButton: UIButton = UIButton(type: .custom)
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        setupTitleLabel()
        setupTextField()
        setupShowHideButton()
        setupViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }*/
    
    //MARK: - Actions
    @objc func textFieldEdited() {
        //Edited
    }
    
    @objc func textFieldEndEditing() {
        print(textField.text)
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
        textField.font = .systemFont(ofSize: 32, weight: .medium)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldEndEditing), for: .touchDown)
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
        mediumView.backgroundColor = .orange
        strongView.backgroundColor = .green
    
        weakView.frame.size = colorViewSize
        mediumView.frame.size = colorViewSize
        strongView.frame.size = colorViewSize
        
        addSubview(weakView)
        //addSubview(mediumView)
        //addSubview(strongView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: weakView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: weakView, attribute: ., relatedBy: <#T##NSLayoutConstraint.Relation#>, toItem: <#T##Any?#>, attribute: <#T##NSLayoutConstraint.Attribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
            
        ])
    }
    
    
    
    
    
}
