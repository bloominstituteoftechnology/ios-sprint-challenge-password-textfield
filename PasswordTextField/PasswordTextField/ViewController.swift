//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func returnHit(_ sender: PasswordField) {
        
        switch sender.password.count {
        case 10...19:
            print("You have entered a meduim password, your password is: \(sender.password)")
        case 20...Int.max:
            print("You have entered a Strong password, your password is: \(sender.password)")
        default:
            print("You have entered a weak password, your password is: \(sender.password)")
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//
//        // Uncomment this portion to set up the dictionary
//        let str = "lambda"
//        let referenceVC = UIReferenceLibraryViewController(term: str)
//        present(referenceVC, animated: true, completion: nil)
    }
}
