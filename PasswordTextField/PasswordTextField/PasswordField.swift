//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import SwiftUI

enum PasswordStrength {
    case weak, medium, strong
}

class PasswordField: UIControl {
    
    
    // MARK: - Propertiese
    
    // Public API - these properties are used to fetch the final password and strength values
    private(set) var password: String = "" { didSet { sendActions(for: .valueChanged) }}
    private(set) var strength: PasswordStrength = .weak
    
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Private
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldMargin: CGFloat = 6.0
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldCornerRadius: CGFloat = 6.0
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let textFieldBorderWidth: CGFloat = 2.0
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    // Initialize Views
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let showHideButton = UIButton()
    private let weakView = UIView()
    private let mediumView = UIView()
    private let strongView = UIView()
    private let strengthDescriptionLabel = UILabel()
    
    private lazy var colorViews = [weakView, mediumView, strongView]
    private lazy var strengthStack = UIStackView(arrangedSubviews: [weakView, mediumView, strongView, strengthDescriptionLabel])
    private lazy var vStack = UIStackView(arrangedSubviews: [titleLabel, textField, strengthStack])
    
    
    // MARK: - Setup
    
    
    func setup() {
        backgroundColor = bgColor
        setupVStack()
        setupTitleLabel()
        setupTextField()
        setupShowHideButton()
        setupStrengthStack()
    }
    
    private func setupVStack() {
        addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        vStack.spacing = standardMargin
        vStack.setCustomSpacing(textFieldMargin, after: titleLabel)
        
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.directionalLayoutMargins = .init(top: standardMargin, leading: standardMargin, bottom: standardMargin, trailing: standardMargin)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
    }
    
    private func setupTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = textFieldBorderWidth
        textField.layer.cornerRadius = textFieldCornerRadius
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.backgroundColor = .clear
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
    }
    
    private func setupShowHideButton() {
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.setImage(UIImage(named: "eyes-open"), for: [.selected])
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor),
            showHideButton.rightAnchor.constraint(equalTo: textField.rightAnchor),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
            showHideButton.widthAnchor.constraint(equalTo: showHideButton.heightAnchor),
        ])
    }
    
    private func setupStrengthStack() {
        strengthStack.translatesAutoresizingMaskIntoConstraints = false
        
        strengthStack.distribution = .fill
        strengthStack.alignment = .center
        strengthStack.spacing = 2
        
        colorViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
            $0.widthAnchor.constraint(lessThanOrEqualToConstant: colorViewSize.width).isActive = true
            $0.layer.cornerRadius = colorViewSize.height / 2
        }
        
        weakView.backgroundColor = weakColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        strengthStack.setCustomSpacing(textFieldMargin, after: strongView)
        
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
    }
    
    
    // MARK: - Updating
    
    private func determineStrength(of password: String) {
        switch password.count {
        case 0...5:
            strength = .weak
        case 6...8:
            strength = .medium
        default:
            strength = .strong
        }
        
        updateStrengthViews()
    }
    
    private func updateStrengthViews() {
        switch strength {
        case .weak:
            strengthDescriptionLabel.text = "Too weak"
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case .medium:
            strengthDescriptionLabel.text = "Could be stronger"
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        case .strong:
            strengthDescriptionLabel.text = "Strong password"
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
    
    // MARK: - Actions
    
    @objc func showHideButtonTapped() {
        showHideButton.isSelected.toggle()
        textField.isSecureTextEntry = !showHideButton.isSelected
    }
}


// MARK: - Text Field Delegate

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        determineStrength(of: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let passwordText = textField.text else { return false }
        password = passwordText
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - SwiftUI Preview

struct ViewWrapper: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ViewWrapper>) -> UIView {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "VC").view
    }
    
    func updateUIView(_ uiView: ViewWrapper.UIViewType, context: UIViewRepresentableContext<ViewWrapper>) {
    }
}

struct ViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ViewWrapper()
    }
}

