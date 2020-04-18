//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var passwordField: PasswordField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc @IBAction func passwordEntered(_ sender: Any) {
        resignFirstResponder()
        NSLog(passwordField.password)
        NSLog(passwordField.strengthDescriptionLabel.text ?? "")
     }
    
}
