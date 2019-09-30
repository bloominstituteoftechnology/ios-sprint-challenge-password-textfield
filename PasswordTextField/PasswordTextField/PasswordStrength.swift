//
//  PasswordStrength.swift
//  PasswordTextField
//
//  Created by Casualty on 9/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum PasswordStrength: String {
    case blank = ""
    case tooWeak = "Too Weak"
    case couldBeStronger = "Could Be Stronger"
    case strongPassword = "Strong Password"
}
