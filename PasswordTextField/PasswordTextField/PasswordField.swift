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
    
    private (set) var strength: PasswordStrength = .weak {
        didSet{
            animatePasswordStrength()
        }
    }
        
    enum PasswordStrength {
        case weak, medium, strong
    }
    
    
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
        // Lay out your subviews here
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkGray
        titleLabel.text = "Enter a password"
    
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 2
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10 ).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.placeholder = " 0000"
        textField.isSecureTextEntry = true
        textField.font = .systemFont(ofSize: 30)
        textField.addTarget(self, action: #selector(changeBorderColor), for: .touchDown)

        
        addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        showHideButton.addTarget(self, action: #selector(hideShowButtonSet), for: .touchDown)
        showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -45).isActive = true
        showHideButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
       
        showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .selected)
        
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        weakView.layer.borderWidth = 1
        weakView.layer.cornerRadius = 6
        weakView.layer.backgroundColor = unusedColor.cgColor
        
        
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        mediumView.layer.borderWidth = 1
        mediumView.layer.cornerRadius = 6
        mediumView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        strongView.layer.borderWidth = 1
        strongView.layer.cornerRadius = 6
        strongView.layer.backgroundColor = unusedColor.cgColor
        
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.text = "         "
        strengthDescriptionLabel.textAlignment = .center
        
        let stackView = UIStackView()
               stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
               
               
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        
        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)
        stackView.addArrangedSubview(strengthDescriptionLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func animatePasswordStrength() {
        switch strength{
        case .weak:
            weakView.layer.backgroundColor = weakColor.cgColor
            mediumView.layer.backgroundColor = unusedColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            UIView.animate(withDuration: 0.3, animations: {
                                      self.weakView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                                  }) { _ in
                                      UIView.animate(withDuration: 0.3) {
                                          self.weakView.transform = .identity
                                      }
                                  }
           
            strengthDescriptionLabel.text = " too weak"
        
        case .medium:
            mediumView.layer.backgroundColor = mediumColor.cgColor
            strongView.layer.backgroundColor = unusedColor.cgColor
            UIView.animate(withDuration: 0.3, animations: {
                           self.weakView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                       }) { _ in
                           UIView.animate(withDuration: 0.3) {
                               self.weakView.transform = .identity
                           }
                       }
            UIView.animate(withDuration: 0.3, animations: {
                self.mediumView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.mediumView.transform = .identity
                }
            }
            strengthDescriptionLabel.text = " stronger.."
            
            
        case .strong:
            strongView.layer.backgroundColor = strongColor.cgColor
            strengthDescriptionLabel.text = " Strong!"
            UIView.animate(withDuration: 0.3, animations: {
                           self.weakView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                       }) { _ in
                           UIView.animate(withDuration: 0.3) {
                               self.weakView.transform = .identity
                           }
                       }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.mediumView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }) { _ in
                UIView.animate(withDuration: 0.3) {
                    self.mediumView.transform = .identity
                }
            }
            UIView.animate(withDuration: 0.3, animations: {
                           self.strongView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                       }) { _ in
                           UIView.animate(withDuration: 0.3) {
                               self.strongView.transform = .identity
                           }
                       }
            
        }
    }
    
    func isPasswordStrong(for password: String) {
        switch password.count {
        case 6...12:
            if strength != .medium {
                strength = .medium
            }
        case 13...50:
            if strength != .strong {
                strength = .strong
            }
        case 1:
            strength = .weak
            
        default:
            return
            }
            
        }
    
    @objc func changeBorderColor() {
        textField.layer.borderColor = textFieldBorderColor.cgColor
    }
    
    @objc func hideShowButtonSet() {
        textField.isSecureTextEntry.toggle()
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .normal)
        }
    }
    

}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        isPasswordStrong(for: newText)
        return true
    }
}
