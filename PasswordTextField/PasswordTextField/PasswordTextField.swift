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
@IBDesignable class PasswordField: UIControl, UITextFieldDelegate {
    
    // MARK: Private properties
    
    private (set) var password: String = ""
    
    var strengthOfPassword: PasswordStrength {
        switch password.count {
        case 0...9:
            return .weak
        case 10...19:
            return .medium
        default:
            return .strong
        }
    }
    // Margin and size properties
    private let margin: CGFloat = 10.0
    private let tfContainerHeight: CGFloat = 75.0
    private let colorViewSize: CGSize = CGSize(width: 70, height: 10)
    private let textFieldMargins: CGFloat = 6.0
    private let cornerRadius: CGFloat = 5.0
    
    // Text field properties
    private let textFieldBorderWidth: CGFloat = 3.0
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let tfBGColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // Label properties
    private let labelFontSize = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
    private let textColor: UIColor = .black
    
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
    
    // MARK: - View LifeCyle
    required override init(frame: CGRect) {
        super.init(frame: frame)
        viewConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewConfig()
    }
    
    // MARK: - private & internal helper funcs
    
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
    
    
    // MARK: View Configuration
    
    private func viewConfig() {
        backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
        
        // Text field config
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = textFieldBorderWidth
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.cornerRadius = cornerRadius
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
