//
//  Login.swift
//  LoginScreen
//
//  Created by brian vilchez on 11/8/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class Login: UIView {

   private lazy var LoginContainer: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.backgroundColor = .white
       view.layer.cornerRadius = 20
       return view
   }()
    
    private lazy var LoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var usernameView: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8430543542, green: 0.8431970477, blue: 0.88169384, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var usernameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "enter username"
        textfield.delegate = self
        textfield.becomeFirstResponder()
        return textfield
    }()
    
    private lazy var passwordView: UIView =  {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8430543542, green: 0.8431970477, blue: 0.88169384, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var passwordTextfield: UITextField = {
          let textfield = UITextField()
          textfield.translatesAutoresizingMaskIntoConstraints = false
          textfield.placeholder = "enter password"
          textfield.isSecureTextEntry = true
          textfield.delegate = self
          return textfield
      }()
    
    private lazy var loginButtonVIew: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        return button
    }()
    
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    let weakView: UIView = UIView()
    let mediumView: UIView = UIView()
    let strongView: UIView = UIView()
    private (set) var password: String = ""
    
      
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
   
    override func layoutSubviews() {
        setupViews()
    }

    @objc func loginButtonPressed() {
        print("hi!!")
    }
    
    @objc func showPassword(_ sender: UIButton) {
        if sender.isSelected != sender.isSelected {
            passwordTextfield.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
           passwordTextfield.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage(named: "eyes-opened"), for: .normal)
        }
    }
    
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .darkGray
        setupCustomViews()
    }
  private func setupCustomViews() {
    
    /// setup for the sub view that will contain the username and passwordtextfield s
    self.addSubview(LoginContainer)
    LoginContainer.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    LoginContainer.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    LoginContainer.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
    LoginContainer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
    
    
    /// setup for the login label
    LoginContainer.addSubview(LoginLabel)
    LoginLabel.leadingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.leadingAnchor).isActive = true
    LoginLabel.trailingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.trailingAnchor).isActive = true
    LoginLabel.topAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.topAnchor).isActive = true
    
    
    ///setup for usernameView
    LoginContainer.addSubview(usernameView)
    usernameView.leadingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    usernameView.trailingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    usernameView.topAnchor.constraint(equalToSystemSpacingBelow: LoginLabel.bottomAnchor, multiplier: 2).isActive = true
    usernameView.heightAnchor.constraint(equalToConstant: 70).isActive = true

    
    /// setup for passwordView
    LoginContainer.addSubview(passwordView)
    passwordView.leadingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    passwordView.trailingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    passwordView.topAnchor.constraint(equalToSystemSpacingBelow: usernameView.bottomAnchor, multiplier: 2).isActive = true
    passwordView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    
    ///set up for button view
    LoginContainer.addSubview(loginButtonVIew)
    loginButtonVIew.leadingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
    loginButtonVIew.trailingAnchor.constraint(equalTo: LoginContainer.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
    loginButtonVIew.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.bottomAnchor, multiplier: 5).isActive = true
    loginButtonVIew.heightAnchor.constraint(equalToConstant: 70).isActive = true
    
    ///setup for button
    loginButtonVIew.addSubview(loginButton)
    loginButton.leadingAnchor.constraint(equalTo: loginButtonVIew.leadingAnchor).isActive = true
    loginButton.trailingAnchor.constraint(equalTo: loginButtonVIew.trailingAnchor).isActive = true
    loginButton.topAnchor.constraint(equalTo: loginButtonVIew.topAnchor).isActive = true
    loginButton.bottomAnchor.constraint(equalTo: loginButtonVIew.bottomAnchor).isActive = true
    
    setupTextfields()
    SetupStrengthBar()
    }
    
    
    private func setupTextfields() {
        
        usernameView.addSubview(usernameTextfield)
        usernameTextfield.leadingAnchor.constraint(equalTo: usernameView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        usernameTextfield.trailingAnchor.constraint(equalTo: usernameView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        usernameTextfield.topAnchor.constraint(equalTo: usernameView.topAnchor).isActive = true
        usernameTextfield.bottomAnchor.constraint(equalTo: usernameView.bottomAnchor).isActive = true
        
        passwordView.addSubview(passwordTextfield)
        passwordTextfield.leadingAnchor.constraint(equalTo: passwordView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordTextfield.trailingAnchor.constraint(equalTo: passwordView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: passwordView.topAnchor).isActive = true
        passwordTextfield.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor).isActive = true

    }
    
    private func SetupStrengthBar() {
        

        addSubview(weakView)
            weakView.layer.borderWidth = 1
            weakView.layer.cornerRadius = 5
            weakView.backgroundColor = unusedColor
            weakView.translatesAutoresizingMaskIntoConstraints = false
            weakView.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.bottomAnchor, multiplier: 1).isActive = true
            weakView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor,constant: 8).isActive = true
            weakView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            weakView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            
           addSubview(mediumView)
            mediumView.layer.borderWidth = 1
            mediumView.layer.cornerRadius = 5
            mediumView.backgroundColor = unusedColor
            mediumView.translatesAutoresizingMaskIntoConstraints = false
            mediumView.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.bottomAnchor, multiplier: 1).isActive = true
            mediumView.leadingAnchor.constraint(equalToSystemSpacingAfter: weakView.trailingAnchor, multiplier: 0.5).isActive = true
            mediumView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            mediumView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            
            addSubview(strongView)
            strongView.layer.borderWidth = 1
            strongView.layer.cornerRadius = 5
            strongView.backgroundColor = unusedColor
            strongView.translatesAutoresizingMaskIntoConstraints = false
            strongView.topAnchor.constraint(equalToSystemSpacingBelow: passwordView.bottomAnchor, multiplier: 1).isActive = true
            strongView.leadingAnchor.constraint(equalToSystemSpacingAfter: mediumView.trailingAnchor, multiplier: 0.5).isActive = true
            strongView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            strongView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            
        
    }
}

extension Login: UITextFieldDelegate {
    
    private func determineStrength(for password: String) {
      
          if password.count == 0 {
              weakView.backgroundColor = unusedColor
              mediumView.backgroundColor = unusedColor
              strongView.backgroundColor = unusedColor
          } else if password.count <= 9 {
              weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
          } else if password.count <= 19 {
              weakView.backgroundColor = weakColor
              mediumView.backgroundColor = mediumColor
             strongView.backgroundColor = unusedColor
          } else if password.count > 20 {
              weakView.backgroundColor = weakColor
              mediumView.backgroundColor = mediumColor
              strongView.backgroundColor = strongColor
          }
      }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == passwordTextfield {
          let oldText = textField.text!
          let stringRange = Range(range, in: oldText)!
          let newText = oldText.replacingCharacters(in: stringRange, with: string)
          // TODO: send new text to the determine strength method
          password = newText
          self.determineStrength(for: password)
        //  print(newText)
          return true
        } else {
            return true
        }
    
      }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextfield {
            textField.resignFirstResponder()
            passwordTextfield.becomeFirstResponder()
            return true
        } else if textField == passwordTextfield {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
}
