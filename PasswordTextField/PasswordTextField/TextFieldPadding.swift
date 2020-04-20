////
////  TextFieldPadding.swift
////  PasswordTextField
////
////  Created by Matthew Martindale on 4/19/20.
////  Copyright © 2020 Lambda School. All rights reserved.
////
//
//import Foundation
//
//class UITextFieldPadding : UITextField {
//
//  let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//  }
//
//  override func textRect(forBounds bounds: CGRect) -> CGRect {
//    return bounds.inset(by: padding)
//  }
//
//  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//    return bounds.inset(by: padding)
//  }
//
//  override func editingRect(forBounds bounds: CGRect) -> CGRect {
//    return bounds.inset(by: padding)
//  }
//}
