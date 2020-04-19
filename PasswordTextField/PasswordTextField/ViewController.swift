//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func passwordFieldControl(_ sender: PasswordField) {
       print("Password is: \(sender.password)")
        print("Password strength is: \(sender.passwordStrength.rawValue)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
