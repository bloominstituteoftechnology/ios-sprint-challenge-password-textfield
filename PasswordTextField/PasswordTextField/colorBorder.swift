//
//  colorBorder.swift
//  PasswordTextField
//
//  Created by Lambda_School_Loaner_241 on 4/17/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class colorBorder: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if let context = UIGraphicsGetCurrentContext() {
            let myRect = CGRect(x: 20, y: 50, width: 200, height: 300)
            context.addRect(myRect)
            context.setFillColor(UIColor.gray.cgColor)
            context.fillPath()
            
        }
    }
    

}
