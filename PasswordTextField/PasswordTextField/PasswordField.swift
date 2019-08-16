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
    
    var textIsHidden: Bool = false
    
    func setup() {
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5), titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5)])
        
        titleLabel.text = "ENTER PASSWORD"
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5), textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30), textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 5),
            textField.heightAnchor.constraint(equalToConstant: 40)])
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.blue.cgColor
        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-opened"), for: .normal)
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([showHideButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 5), showHideButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 45)])
        
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
//        let strengthBarStackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
//        strengthBarStackView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(strengthBarStackView)
//        NSLayoutConstraint.activate([strengthBarStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5), strengthBarStackView])
        
    }
    
    @objc func showHideButtonTapped() {
        if textIsHidden {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textIsHidden.toggle()
        } else {
            showHideButton.setImage(UIImage(named: "eyes-opened"), for: .normal)
            textIsHidden.toggle()
        }
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
