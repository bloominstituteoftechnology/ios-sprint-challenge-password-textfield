//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func passwordHasChangedValue(_ passwordField: PasswordField) {
        let currentPassword = passwordField.password
            let passwordStrength = passwordField.passwordStrength.rawValue
            print("Entered Password: \(currentPassword). Password Strength: \(passwordStrength.capitalized)")
    }
}
