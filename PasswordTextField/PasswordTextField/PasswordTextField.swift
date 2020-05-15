//
//  PasswordTextField.swift
//  PasswordTextField
//
//

import UIKit

@IBDesignable class PasswordTextField: UIControl {

    enum PasswordStrength: Int {
        case weak
        case medium
        case strong
    }
    @IBDesignable class PasswordField: UIControl {
        // Properties
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
        private let textFieldBorderColor: UIColor = .blue
        private let tfBGColor: UIColor = .white
        
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
        
    }
    
    
    
    
}
