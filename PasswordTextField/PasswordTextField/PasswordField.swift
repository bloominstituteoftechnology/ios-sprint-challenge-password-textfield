//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

//Did not use Enum in Code
enum PasswordEnum: String {
    case weak
    case medium
    case strong
}

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
    
    func setup() {
        
        //Title Label
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let tlTop = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        let tlLeading = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2)
        let tlWidth = titleLabel.widthAnchor.constraint(equalToConstant: 150)
        let tlHeight = titleLabel.heightAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([tlTop, tlLeading, tlWidth, tlHeight])
        
        
        //Textfield
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = " Enter Password"
        textField.font = labelFont
        textField.textColor = labelTextColor
        
        let tfTop = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        let tfLeading = textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2)
        let tfTrailing = textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2)
        let tfHeight = textField.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([tfTop, tfLeading, tfTrailing, tfHeight])
        
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.backgroundColor = bgColor
        self.backgroundColor = bgColor
        textField.layer.borderWidth = 1
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 4
        textField.isSecureTextEntry = true
        

        
        //Weak, Medium, Strong Views
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let wvHeight = weakView.heightAnchor.constraint(equalToConstant: 5)
        let wvWidth = weakView.widthAnchor.constraint(equalToConstant: 60)
        let mvHeight = mediumView.heightAnchor.constraint(equalToConstant: 5)
        let mvWidth = mediumView.widthAnchor.constraint(equalToConstant: 60)
        let strongHeight = strongView.heightAnchor.constraint(equalToConstant: 5)
        let strongWidth = strongView.widthAnchor.constraint(equalToConstant: 60)
        
        NSLayoutConstraint.activate([wvWidth, wvHeight, mvWidth, mvHeight, strongHeight, strongWidth])
        
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(strongView)
        
        // Adding The Views to a Horizontal StackView
        let stackView = UIStackView(arrangedSubviews: [weakView, mediumView, strongView])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
       
        addSubview(stackView)
        
        let svTop = stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10)
        let svLeading = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2)
        let svWidth = stackView.widthAnchor.constraint(equalToConstant: 186)
        let svHeight = stackView.heightAnchor.constraint(equalToConstant: 5)
        
        NSLayoutConstraint.activate([svTop, svWidth, svLeading, svHeight])
       
        //Strength Description Label
        strengthDescriptionLabel.text = "Too Weak"
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
        let sdlLeading = strengthDescriptionLabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 5)
        let sdlTrailing = strengthDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        let sdlHeight = strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 15)
        let sdlTop = strengthDescriptionLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -5)
        
        NSLayoutConstraint.activate([sdlLeading, sdlTrailing, sdlHeight, sdlTop])
        
        
        //Show Hide Button
        
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.isUserInteractionEnabled = true
       
        
//        self.bringSubviewToFront(showHideButton)
//
//        let shbTrailing = showHideButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
//        let shbTop = showHideButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        
        
        let shbWidth = showHideButton.widthAnchor.constraint(equalToConstant: 20)
        let shbHeight = showHideButton.heightAnchor.constraint(equalToConstant: 20)
        
        showHideButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        showHideButton.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        textField.rightViewMode = .always
        textField.rightView = showHideButton
        showHideButton.addTarget(showHideButton, action: #selector(self.showButtonTapped), for: .allTouchEvents)
        
        
        NSLayoutConstraint.activate([shbWidth, shbHeight])

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func calculatePasswordStrength(password: String) {
        switch password.count {
        case 0...9:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too Weak"
            viewAnimate(password: password)
        case 10...19:
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could Be Stronger"
            viewAnimate(password: password)
        case 20...99:
            strongView.backgroundColor = strongColor
            mediumView.backgroundColor = mediumColor
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Strong Password"
            viewAnimate(password: password)
        default:
            break
        }

        
    }
    
    func viewAnimate(password: String) {
        switch password.count {
        case 1:
            animation(view: weakView)
        case 10:
            animation(view: mediumView)
        case 20:
            animation(view: strongView)
        default:
            break
        }
    }
    
    func animation(view: UIView) {
        UIView.animate(withDuration: 0.75, animations: {
            view.transform = CGAffineTransform(scaleX: 1.10, y: 1.25)
        }) { (_) in
            view.transform = .identity
        }
    }
    
    @objc func showButtonTapped() {
        print("working")
        if showHideButton.currentImage == UIImage(named: "eyes-closed") {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else if showHideButton.currentImage == UIImage(named: "eyes-open") {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        calculatePasswordStrength(password: newText)
        // TODO: send new text to the determine strength method
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {return false}
        password = text
        sendActions(for: .valueChanged)
        textField.resignFirstResponder()
        return false
        
    }
}
