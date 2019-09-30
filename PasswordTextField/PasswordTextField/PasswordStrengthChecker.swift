//
//  PasswordStrengthChecker.swift
//  PasswordTextField
//
//  Created by Vici Shaweddy on 9/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum PasswordStrength {
    case weak, medium, strong
}

struct PasswordStrengthChecker {
    func strength(for password: String) -> PasswordStrength {
        var strength: PasswordStrength
        
        switch password.count {
        case 0...9:
            strength = .weak
        case 10...19:
            strength = .medium
        case _ where password.count >= 20:
            strength = .strong
        default:
            strength = .weak
        }
        
        return strength
    }
}
