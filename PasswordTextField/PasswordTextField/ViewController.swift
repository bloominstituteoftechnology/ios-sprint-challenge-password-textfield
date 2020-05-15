//
//  ViewController.swift
//  PasswordTextField
//
//

import UIKit

class ViewController: UIViewController {
    
    let passwordField = PasswordField()
    
    @IBAction func passwordFieldReturned(_ passwordField: PasswordField) {
        var pwdStrength: PasswordStrength = .weak
        
        if passwordField.checkDictionary() {
            switch passwordField.strengthOfPassword {
            case .weak:
                pwdStrength = .weak
            case .medium:
                pwdStrength = .weak
            case .strong:
                pwdStrength = .medium
            }
        }
        print("The password is \(passwordField.password) and the strength is \(pwdStrength)")
    }
}
        // For use in the stretch goal
        //
        // Uncomment this entire method, then run the app.
        // A dictionary view should appear, with a "manage" button
        // in the lower left corner. Tap that button and choose a dictionary
        // to install (you can use the first one "American English"). Tap
        // the little cloud download button to install it. Then just stop the app
        // and comment this method out again. This step only needs to run once.
//
//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//
//            // Uncomment this portion to set up the dictionary
//            let str = "lambda"
//            let referenceVC = UIReferenceLibraryViewController(term: str)
//            present(referenceVC, animated: true, completion: nil)
//        }
//    }
//


