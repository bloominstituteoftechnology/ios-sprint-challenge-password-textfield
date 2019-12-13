//
//  PasswordTextField.swift
//  PasswordTextField
//
//  Created by Chad Rutherford on 12/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
