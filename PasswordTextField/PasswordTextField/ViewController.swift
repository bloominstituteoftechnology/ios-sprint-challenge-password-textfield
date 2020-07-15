//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var password: PasswordField!
 
  @IBAction func editChanged(_ sender: PasswordField) {}
  
  @IBAction func touchUpInside(_ sender: PasswordField) {}
  
  @IBAction func textFieldValueChanged(_ sender: PasswordField) {
    
    print("Password is \(sender.password), strength level is \(sender.strengthDescriptionLabel.text ?? "").")
    
  }
}
