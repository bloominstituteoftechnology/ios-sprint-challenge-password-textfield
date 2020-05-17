//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBAction func changeValue(_ sender: SignupPage) {
        print(sender.password)
        
        if sender.password.count <= 4 {
            print("Too Weak")
        } else if sender.password.count >= 5 && sender.password.count <= 6 {
            print("Could Be Stronger")
        } else {
            print("Strong Password")
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
