//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum Strength {
    case strong
    case medium
    case weak
}

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private (set) var passwordStrength: Strength = .weak
    
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
    
    private var tfBorder: UIView = UIView()
    
    func setup() {
        // Lay out your subviews here
        congfigureLabel()
        configureTextField()
        configureViews()
    }
    
    func congfigureLabel() {
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
    }
    
    func configureTextField() {
        //textField.borderStyle = .roundedRect
//        tfBorder.backgroundColor = textFieldBorderColor
//        addSubview(tfBorder)
//        tfBorder.translatesAutoresizingMaskIntoConstraints = false
//
//        tfBorder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin - 1).isActive = true
//        tfBorder.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin - 1).isActive = true
//        tfBorder.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin + 1).isActive = true
//        tfBorder.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        // bottom border needs fixing

        textField.backgroundColor = bgColor
        
        //textField.resignFirstResponder()
        
        textField.placeholder = "Enter password"
        
        
        addSubview(textField) //??
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -standardMargin - textFieldContainerHeight).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        // Button
        let button = UIButton()
        button.titleLabel?.text = "btn"
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        //button.imageView!.image = UIImage(named: "eyes-open")
        button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        button.leadingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
        //button.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        //button.widthAnchor.constraint(equalToConstant: textField.frame.width).isActive = true
        
        print(button.frame.origin)
    }
    
    func configureViews() {
        // Weak
        weakView.backgroundColor = unusedColor
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        weakView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        weakView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: standardMargin).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        // Medium
        mediumView.backgroundColor = unusedColor
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        mediumView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        // Stronk
        strongView.backgroundColor = unusedColor
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false

        strongView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        // Strength Description Label
        //strengthDescriptionLabel.backgroundColor = .cyan
        strengthDescriptionLabel.text = "Too Weak"
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        strengthDescriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        
        // center vertically with str views?
        
    }
    
    @objc func buttonTapped() {
        print("button")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        textField.delegate = self
    }
    
    func checkStrength() {
        
    }
    
    // MARK: - Touch Trackers
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if textField.frame.contains(touchPoint) {
            print("tapped inside the bounds of textfield")
        }
        print("begin tracking") // not printing
        sendActions(for: [.touchDown, .touchUpInside, .valueChanged])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event) }
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            
            sendActions(for: [.touchUpInside])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
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

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}
