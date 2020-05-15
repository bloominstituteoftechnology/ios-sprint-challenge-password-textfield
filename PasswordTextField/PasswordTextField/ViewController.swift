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
        print("\(sender.password)")
        print("\(sender.passwordCheck())")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        // Uncomment this portion to set up the dictionary
//        let str = "lambda"
//        let referenceVC = UIReferenceLibraryViewController(term: str)
//        present(referenceVC, animated: true, completion: nil)
//    }
}
