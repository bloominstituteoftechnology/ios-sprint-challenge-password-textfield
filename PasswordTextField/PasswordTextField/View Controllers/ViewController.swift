//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBActions
    @IBAction func returnTapped(_ sender: PasswordField) {
        print("Password is: \(sender.password) with a type of: \(sender.strength.rawValue)")
    }
    
}
