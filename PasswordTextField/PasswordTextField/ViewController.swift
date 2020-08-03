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
        print("The password has changed to: \"\(sender.password)\"")
        print("Password strength: \(sender.passwordStrength.rawValue)")
    }
}
