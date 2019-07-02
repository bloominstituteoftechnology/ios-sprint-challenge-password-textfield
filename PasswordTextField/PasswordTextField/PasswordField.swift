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
        self.backgroundColor = #colorLiteral(red: 0.9259146733, green: 0.9259146733, blue: 0.9259146733, alpha: 1)
        self.layer.cornerRadius = 5
        self.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        self.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        self.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40)
        
        
        //titleLabel               = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        titleLabel.text          = "ENTER PASSWORD"
        titleLabel.textAlignment = .left
        titleLabel.font          = labelFont
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLblTopContraint      = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        let titleLblLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        //let titleLblBottomConstraint = titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 84)
        NSLayoutConstraint.activate([titleLblTopContraint, titleLblLeadingConstraint,]) //titleLblBottomConstraint])
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        //textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        //textField.backgroundColor = .red
        textField.layer.borderWidth  = 2
        textField.layer.borderColor  = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = 5
        textField.placeholder        = "Enter Your Password"
        
        self.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        let txtFieldTopContraint       = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        let txtFieldLeadingContraint   = textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5)
        let txtFieldTrailingConstraint = textField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        let txtFeildHeightConstant     = textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)

        NSLayoutConstraint.activate([txtFieldTopContraint, txtFieldLeadingContraint, txtFieldTrailingConstraint, txtFeildHeightConstant])

        //showHideButton = UIButton(type: .custom)
        showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        showHideButton.imageView?.contentMode = UIView.ContentMode.scaleToFill
        //showHideButton.layer.borderWidth = 2
        //showHideButton.layer.borderColor = UIColor.red.cgColor
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.addTarget(self, action: #selector(PasswordField.eyeBtnPressed), for: .touchUpInside)
        
        textField.addSubview(showHideButton)
        textField.rightView     = showHideButton
        textField.rightViewMode = .always
        //showHideButton.center = textField.center

        let btnTrailingConstraint = showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin)
        let btnTopConstraint      = showHideButton.topAnchor.constraint(equalTo: textField.topAnchor)
        let btnBottomConstraint   = showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor)
        let btnHeightConstraint   = showHideButton.heightAnchor.constraint(equalToConstant: textFieldContainerHeight)
        let btnWidthConstraint    = showHideButton.widthAnchor.constraint(equalToConstant: 40.0)

        NSLayoutConstraint.activate([btnTrailingConstraint, btnTopConstraint, btnBottomConstraint, btnHeightConstraint, btnWidthConstraint])


        // MARK: - Bar Indicators
        //weakView    = UIView(frame: CGRect(x: 0, y: 85, width: 25, height: 10))
//        weakView.backgroundColor = .red
//        weakView.systemLayoutSizeFitting(colorViewSize)
//        weakView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(weakView)
//
//
//        //mediumView  = UIView(frame: CGRect(x: 30, y: 85, width: 25, height: 10))
////        mediumView.backgroundColor = .yellow
////        mediumView.sizeThatFits(colorViewSize)
//        mediumView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(mediumView)
//
//
//        //strongView  = UIView(frame: CGRect(x: 60, y: 85, width: 25, height: 10))
////        strongView.backgroundColor = .green
////        strongView.sizeThatFits(colorViewSize)
//        strongView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(strongView)
//
//        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        strengthDescriptionLabel.text      = "Too Weak" // default text
//        strengthDescriptionLabel.textColor = labelTextColor // text color
//        strengthDescriptionLabel.font      = UIFont.boldSystemFont(ofSize: 10)

//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(stackView)
//
//        stackView.axis         = .horizontal
//        stackView.alignment    = .fill
//        stackView.distribution = .equalSpacing
//
//
//        stackView.addArrangedSubview(weakView)
//        stackView.addArrangedSubview(mediumView)
//        stackView.addArrangedSubview(strongView)
//        stackView.addArrangedSubview(strengthDescriptionLabel)
//
//        let stackViewTopConstaint      = stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8)
//        //let stackViewBottomConstraint  = stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
//        let stackViewLeadingConstraint = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
//        let stackViewTrailingConstrain = stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
//
//        NSLayoutConstraint.activate([stackViewTopConstaint, stackViewLeadingConstraint, stackViewTrailingConstrain]) //stackViewBottomConstraint
        
        weakView.backgroundColor = .lightGray
        weakView.layer.cornerRadius = 2
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        
        //weakview constraints
        weakView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        mediumView.backgroundColor = .lightGray
        mediumView.layer.cornerRadius = 2
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        
        //mediumview constraints
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        strongView.backgroundColor = .lightGray
        strongView.layer.cornerRadius = 2
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        
        // strongview constraints
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin * 2).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        
        
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.text = "Too Weak"
        strengthDescriptionLabel.font = UIFont.init(name: "Helvetica", size: 13)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        
        // indicator label constraints
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin + 2.5).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.widthAnchor.constraint(equalToConstant: colorViewSize.width * 2).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: colorViewSize.height * 3).isActive = true
        
        

    }
    
    @objc func eyeBtnPressed() {
        print("Button was tapped")
        if showHideButton.currentImage == UIImage(named: "eyes-closed") {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            textField.isSecureTextEntry = false
        } else {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            textField.isSecureTextEntry = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
       
        
    }
}

enum PWordStrength: String {
    case tooWeak = "Too Weak"
    case medium  = "Could Be Stronger"
    case strong  = "Strong Password"
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        password = newText
        
        let scaleX: CGFloat = 1.1
        let scaleY: CGFloat = 1.5
        
        switch newText.count {
        case 1:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = .lightGray
            strongView.backgroundColor    = .lightGray
            strengthDescriptionLabel.text = PWordStrength.tooWeak.rawValue
            weakView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            UIView.animate(withDuration: 0.5) {
                self.weakView.transform = .identity
            }
        case 2...9:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = .lightGray
            strongView.backgroundColor    = .lightGray
            strengthDescriptionLabel.text = PWordStrength.tooWeak.rawValue
        case 10:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = .lightGray
            strengthDescriptionLabel.text = PWordStrength.medium.rawValue
            mediumView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            UIView.animate(withDuration: 0.5) {
                self.mediumView.transform = .identity
            }
        case 11...19:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = .lightGray
            strengthDescriptionLabel.text = PWordStrength.medium.rawValue
        case 20:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = strongColor
            strengthDescriptionLabel.text = PWordStrength.strong.rawValue
            strongView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            UIView.animate(withDuration: 0.5) {
                self.strongView.transform = .identity
            }
        case 21...Int.max:
            weakView.backgroundColor      = weakColor
            mediumView.backgroundColor    = mediumColor
            strongView.backgroundColor    = strongColor
            strengthDescriptionLabel.text = PWordStrength.strong.rawValue
        default:
            weakView.backgroundColor   = .lightGray
            mediumView.backgroundColor = .lightGray
            strongView.backgroundColor = .lightGray
        }
        
        return true
    }
    
    func resetColors() {
        weakView.backgroundColor   = .lightGray
        mediumView.backgroundColor = .lightGray
        strongView.backgroundColor = .lightGray
        strengthDescriptionLabel.text = PWordStrength.tooWeak.rawValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sendActions(for: .valueChanged)
        resetColors()
        textField.text = ""
        return false
    }
}
