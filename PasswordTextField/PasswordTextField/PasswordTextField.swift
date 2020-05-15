//
//  PasswordTextField.swift
//  PasswordTextField
//
//

import UIKit



enum PasswordStrength: Int {
    case weak
    case medium
    case strong
}
@IBDesignable class PasswordTextField: UIControl, UITextFieldDelegate {
    
    // MARK: Private properties
    
    private (set) var password: String = ""
    
    var strengthOfPassword: PasswordStrength {
        switch password.count {
        case 0...5:
            return .weak
        case 6...10:
            return .medium
        default:
            return .strong
        }
    }
    // Margin and size properties
    private let margin: CGFloat = 8.0
    private let tfContainerHeight: CGFloat = 50.0
    private let colorViewSize: CGSize = CGSize(width: 60, height: 6.0)
    private let textFieldMargins: CGFloat = 6.0
    private let cornerRadius: CGFloat = 5.0
    
    // Text field properties
    private let textFieldBorderWidth: CGFloat = 3.0
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let tfBGColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // Label properties
    private let labelFontSize = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    private let textColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    
    // Creating view obbjects
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private let textFieldContainer = UIView()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDetailLabel: UILabel = UILabel()
    
    // Password strength indicator color properties
    private let noPassInTextField: UIColor = .lightGray
    private let weakColor: UIColor = .red
    private let mediumColor: UIColor = .yellow
    private let strongColor: UIColor = .green
    
    // MARK: - private & internal helper funcs
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        strengthDetailLabel.text = "Too Weak"
        mediumView.backgroundColor = noPassInTextField
        strongView.backgroundColor = noPassInTextField
        sendActions(for: .valueChanged)
        textField.resignFirstResponder()
        return true
    }
    
    private func animate(view: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            view.transform = CGAffineTransform(scaleX: 1.33, y: 1)
        }) { _ in
            view.transform = .identity
        }
    }
    // Fix it suggested change from private to internal func???
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        if newText != "" {
            
            switch strengthOfPassword {
            case .weak:
                strengthDetailLabel.text = "Too Weak"
                mediumView.backgroundColor = noPassInTextField
                strongView.backgroundColor = noPassInTextField
            case .medium:
                strengthDetailLabel.text = "Could Be Stronger"
                if mediumView.backgroundColor == noPassInTextField {
                    animate(view: mediumView)
                    mediumView.backgroundColor = mediumColor
                }
                strongView.backgroundColor = noPassInTextField
            case .strong:
                strengthDetailLabel.text = "Strong Password"
                if strongView.backgroundColor == noPassInTextField {
                    animate(view: strongView)
                    strongView.backgroundColor = strongColor
                }
            }
        }
        return true
    }
    
    @objc private func eyeBalls() {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        }
    }
    // MARK: - Stretch Goal
    func isWordInDict() -> Bool {
        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: password) {
            return true
        }
        return false
    }
    
    
    // MARK: View Configuration
    
    private func viewConfig() {
        backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
        
        // Text field config
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = textFieldBorderWidth
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = cornerRadius
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.setLeftPaddingPoints(margin)
        
        // Text field container
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textFieldContainer)
        
        // Label Config
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.textColor = textColor
        titleLabel.font = labelFontSize
        
        // Strength view config
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = cornerRadius
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.backgroundColor = noPassInTextField
        mediumView.layer.cornerRadius = cornerRadius
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.backgroundColor = noPassInTextField
        strongView.layer.cornerRadius = cornerRadius
        
        // Strength detail label
        strengthDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDetailLabel)
        strengthDetailLabel.text = "Too weak"
        strengthDetailLabel.textColor = textColor
        strengthDetailLabel.font = labelFontSize
        
        // Eyeballs
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.setBackgroundImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(eyeBalls), for: .touchUpInside)
        
        // MARK: Constraint Activation
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: -margin),
            
            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            textFieldContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textFieldContainer.heightAnchor.constraint(equalToConstant: tfContainerHeight),
            
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: margin),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -margin),
            
            weakView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: margin),
            weakView.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            mediumView.topAnchor.constraint(equalTo: weakView.topAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: margin),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strongView.topAnchor.constraint(equalTo: weakView.topAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: margin),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strengthDetailLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor),
            strengthDetailLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: margin),
            
            showHideButton.topAnchor.constraint(equalTo: textField.topAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -margin),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor)
        ])
    }
    // MARK: - View LifeCyle
    required override init(frame: CGRect) {
        super.init(frame: frame)
        viewConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewConfig()
    }
}
// MARK: - View extension for set margins
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

