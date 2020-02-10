//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismiss keyboard when tapping outside textfield
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // For use in the stretch goal
    //
    // Uncomment this entire method, then run the app.
    // A dictionary view should appear, with a "manage" button
    // in the lower left corner. Tap that button and choose a dictionary
    // to install (you can use the first one "American English"). Tap
    // the little cloud download button to install it. Then just stop the app
    // and comment this method out again. This step only needs to run once.
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //
    //        // Uncomment this portion to set up the dictionary
    //        let str = "lambda"
    //        let referenceVC = UIReferenceLibraryViewController(term: str)
    //        present(referenceVC, animated: true, completion: nil)
    //    }
}
