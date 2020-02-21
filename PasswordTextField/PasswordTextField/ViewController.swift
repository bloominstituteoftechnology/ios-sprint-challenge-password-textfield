//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordField: PasswordField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    }
    
    @IBAction func passwordHasChanged(_ passwordField: PasswordField) {
        let password = passwordField.password
        var passwordStrenth = ""
        
        if password.count <= 10 {
            passwordStrenth = "Weak"
        } else if password.count <= 20 {
            passwordStrenth = "Medium"
        } else {
            passwordStrenth = "Strong"
        }
        
        print(password)
        print(passwordStrenth)
    }
}
