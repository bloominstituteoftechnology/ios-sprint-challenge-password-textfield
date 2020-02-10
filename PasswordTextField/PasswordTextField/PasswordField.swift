import UIKit

class PasswordField: UIControl {
    
    
    // MARK: - Properties
    
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
    private var stackView: UIStackView = UIStackView()

    
    // MARK: - View Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        updateColorsAndText(for: "")
        updateEye()
    }
    
    
    // MARK: - Functions
    
    func setup() {
        // Setting Background Color
        backgroundColor = self.bgColor
        
        
        // Title Label
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        
        
        // Textfield
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.rightViewMode = .always
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
        button.contentEdgeInsets.left = 8
        button.contentEdgeInsets.right = 8
        button.contentEdgeInsets.top = 8
        button.contentEdgeInsets.bottom = 8
        
        textField.rightView = button
        
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = textFieldBorderColor.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 6.0
        textField.backgroundColor = UIColor.clear
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        textField.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        
        // Strength Views
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        weakView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        strengthDescriptionLabel.text = "test"
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.textColor = labelTextColor
        
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
        
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(weakView)
        stackView.addArrangedSubview(mediumView)
        stackView.addArrangedSubview(strongView)
        stackView.addArrangedSubview(strengthDescriptionLabel)
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: standardMargin).isActive = true
        stackView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -standardMargin).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height).isActive = true
        strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width).isActive = true
        
        self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }
    
    fileprivate func updateColorsAndText(for text: String) {
        switch text.count {
        case 0...9:
            strengthDescriptionLabel.text = "Too weak"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
        case 10...19:
            strengthDescriptionLabel.text = "Could be stronger"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
        default:
            strengthDescriptionLabel.text = "Strong Password"
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
        }
    }
    
    fileprivate func updateEye() {
        let image: UIImage? = textField.isSecureTextEntry ? UIImage(named: "eyes-closed") : UIImage(named: "eyes-open")
        guard let button = textField.rightView as? UIButton else { return }
        button.setImage(image, for: .normal)
    }
    
    @objc fileprivate func buttonWasTapped() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        updateEye()
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        
        updateColorsAndText(for: newText)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text)
        print(strengthDescriptionLabel.text)
        return true
    }
}
