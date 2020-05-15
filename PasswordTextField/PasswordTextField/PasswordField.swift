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
@IBDesignable class PasswordField : UIControl {

    // MARK: Private properties
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    var strengthOfPassword: PasswordStrength {
        switch password.count {
        case 0...7:
            return .weak
        case 8...14:
            
            return .medium
        default:
            
            return .strong
        }
    }
    
    var showPassword: Bool = true {
        didSet {
            textField.isSecureTextEntry = showPassword
            if showPassword {
                showHideButton.setImage(UIImage(named: "eyes-closed.png"), for: .normal)
            } else {
                showHideButton.setImage(UIImage(named: "eyes-open.png"), for: .normal)
            }
        }
    }
    // Margin and size properties
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let cornerRadius: CGFloat = 5.0
    private let colorViewSize: CGSize = CGSize(width: 60, height: 5.0)
    
    // Text field properties
    private let textFieldBorderWidth: CGFloat = 3.0
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // Label properties
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    
    
    // Creating view obbjects
    private var titleLabel: UILabel = UILabel()
    private var textField: UITextField = UITextField()
    private let textFieldContainer = UIView()
    var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    // Password strength indicator color properties
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    // MARK: - private & internal helper funcs
    
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        strengthDescriptionLabel.text = "Too Weak"
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
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
    
    @objc private func eyeBalls(button: UIButton) {
        print("Eyeballs")
        showPassword.toggle()
    }
    
    // MARK: - Stretch Goal
    func checkDictionary() -> Bool {
        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: password) {
            return true
        }
        return false
    }
    
    // MARK: View Configuration
    
    private func setup() {
        
        backgroundColor = bgColor
        
        // Text field config
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = textFieldBorderWidth
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = cornerRadius
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.setMargin(textFieldMargin)
        
        // Text field container
        textFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        textFieldContainer.addSubview(textField)
        addSubview(textFieldContainer)
        
        // Label Config
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        
        // Strength view config
        weakView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weakView)
        weakView.backgroundColor = weakColor
        weakView.layer.cornerRadius = cornerRadius
        
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mediumView)
        mediumView.backgroundColor = unusedColor
        mediumView.layer.cornerRadius = cornerRadius
        
        strongView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strongView)
        strongView.backgroundColor = unusedColor
        strongView.layer.cornerRadius = cornerRadius
        
        // Strength detail label
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.text = "Too weak"
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        
        // Eyeballs
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(showHideButton)
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(eyeBalls), for: .touchUpInside)
        
        // MARK: Constraint Activation
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin),
            
            textFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin),
            textFieldContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textFieldContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            textFieldContainer.heightAnchor.constraint(equalToConstant: textFieldContainerHeight),
            
            textField.topAnchor.constraint(equalTo: textFieldContainer.topAnchor, constant: standardMargin),
            textField.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: textFieldContainer.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: -standardMargin),
            
            weakView.topAnchor.constraint(equalTo: textFieldContainer.bottomAnchor, constant: standardMargin),
            weakView.leadingAnchor.constraint(equalTo: textFieldContainer.leadingAnchor),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            mediumView.topAnchor.constraint(equalTo: weakView.topAnchor),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strongView.topAnchor.constraint(equalTo: weakView.topAnchor),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
            
            strengthDescriptionLabel.centerYAnchor.constraint(equalTo: strongView.centerYAnchor),
            strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin),
            
            showHideButton.topAnchor.constraint(equalTo: textFieldContainer.topAnchor),
            showHideButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -standardMargin),
            showHideButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor)
        ])
    }
    // MARK: - View LifeCyle
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 160, height: 160)
    }
}
// MARK: - View extension to set margins
extension UITextField {
    func setMargin(_ amount:CGFloat){
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = padding
        self.leftViewMode = .always
    }
}
// Strength view animation
extension UIView {
    
    func viewWiggle() {
        func wiggleView()   { transform = CGAffineTransform(scaleX: 1.5, y: 1.5) }
        
        func returnView() { transform = .identity }
        
        UIView.animate(withDuration: 0.2,
                       animations: { wiggleView() },
                       completion: { _ in UIView.animate(withDuration: 0.2) { returnView() }})
    }
}

extension PasswordField : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        password = newText
        if newText != "" {
            
            switch strengthOfPassword {
            case .weak:
                
                strengthDescriptionLabel.text = "Too Weak"
                mediumView.backgroundColor = unusedColor
                strongView.backgroundColor = unusedColor
            case .medium:
                strengthDescriptionLabel.text = "Could Be Stronger"
                if mediumView.backgroundColor == unusedColor {
                    animate(view: mediumView)
                    mediumView.backgroundColor = mediumColor
                    mediumView.viewWiggle()
                }
                strongView.backgroundColor = unusedColor
            case .strong:
                strengthDescriptionLabel.text = "Strong Password"
                if strongView.backgroundColor == unusedColor {
                    animate(view: strongView)
                    strongView.backgroundColor = strongColor
                    strongView.viewWiggle()
                }
            }
        }
        return true
    }
}

