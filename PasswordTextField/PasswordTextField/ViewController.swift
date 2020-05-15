//
//  ViewController.swift
//  PasswordTextField
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func passwordFieldReturned(_ passwordField: PasswordTextField) {
        var pwdStrength: PasswordStrength = .weak
        if passwordField.isWordInDict() {
            switch passwordField.strengthOfPassword {
            case .weak:
                pwdStrength = .weak
            case .medium:
                pwdStrength = .weak
            case .strong:
                pwdStrength = .medium
            }
        }
        print("The password is \(passwordField.password) and the strength is \(pwdStrength)")
    }
    

}
