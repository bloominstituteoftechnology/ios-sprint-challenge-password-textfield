//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func passwordChanged(_ sender: PasswordField) {
        print("your new password is: \"\(sender.password)\"")
        print("password strength: \(sender.passwordStrength.rawValue)")
    }
    
}
