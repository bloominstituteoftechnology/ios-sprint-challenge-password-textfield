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
    
    private let standardMargin: CGFloat           = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat          = 6.0
    private let colorViewSize: CGSize             = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont      = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor              = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor   = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel      = UILabel()
    private var textField: UITextField   = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView         = UIView()
    private var mediumView: UIView       = UIView()
    private var strongView: UIView       = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        // Lay out your subviews here
        titleLabel               = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        titleLabel.text          = "ENTER PASSWORD"
        titleLabel.textAlignment = .left
        titleLabel.font          = labelFont
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLblTopContraint      = titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5)
        let titleLblLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5)
        //let titleLblBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 84)
        NSLayoutConstraint.activate([titleLblTopContraint, titleLblLeadingConstraint]) //titleLblBottomConstraint
        
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        //textField.backgroundColor = .red
        textField.layer.borderWidth  = 2
        textField.layer.borderColor  = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 5
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let txtFieldTopContraint       = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        let txtFieldLeadingContraint   = textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5)
        let txtFieldTrailingConstraint = textField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        let txtFeildHeightConstant     = textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        
        NSLayoutConstraint.activate([txtFieldTopContraint, txtFieldLeadingContraint, txtFieldTrailingConstraint, txtFeildHeightConstant])
        
        showHideButton = UIButton(type: .custom)
        showHideButton.setBackgroundImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(showHideButton)
        showHideButton.addTarget(textField, action: #selector(showHidePassword), for: .touchUpInside)
        //showHideButton.center = textField.center
        
        let btnTrailingConstraint     = showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -10)
        let btnTopConstraint          = showHideButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 10)
        let btnBottomConstraint       = showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -10)
        let btnAspectRationConstraint = showHideButton.heightAnchor.constraint(equalTo: showHideButton.widthAnchor, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([btnTrailingConstraint, btnTopConstraint, btnBottomConstraint, btnAspectRationConstraint])
        
        weakView    = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        weakView.backgroundColor = .red
        addSubview(weakView)

        mediumView  = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        mediumView.backgroundColor = .yellow
        addSubview(mediumView)

        strongView  = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        strongView.backgroundColor = .green
        addSubview(strongView)

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)

        let stackViewTopConstaint = stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8)
        let stackViewBottomConstraint = stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        let stackViewLeadingConstraint = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)

        NSLayoutConstraint.activate([stackViewTopConstaint, stackViewBottomConstraint, stackViewLeadingConstraint]) //stackViewTopConstaint,


        
    }
    
    @objc func showHidePassword() {
        
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
}
