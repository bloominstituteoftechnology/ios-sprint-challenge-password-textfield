//
//  InsetTextField.swift
//  PasswordTextField
//
//  Created by Vici Shaweddy on 9/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 30 + 16))
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 30 + 16))
    }
}
