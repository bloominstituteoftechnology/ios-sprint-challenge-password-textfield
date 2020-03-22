//
//  PasswordStrength.swift
//  PasswordTextField
//
//  Created by Shawn Gee on 3/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

enum PasswordStrength {
    case weak, medium, strong

    var description: String {
        switch self {
        case .weak:
            return "Too weak"
        case .medium:
            return "Could be stronger"
        case .strong:
            return "Strong password"
        }
    }
    
    static func strength(for password: String) -> PasswordStrength {
        let range = NSRange(password.startIndex..., in: password)
        let misspelledRange = UITextChecker().rangeOfMisspelledWord(in: password, range: range, startingAt: 0, wrap: false, language: "en")
        let passwordIsWord = misspelledRange.location == NSNotFound
        
        switch password.count {
        case 0...5:
            return .weak
        case 6...8:
            return passwordIsWord ? .weak : .medium
        default:
            return passwordIsWord ? .medium : .strong
        }
    }
}
