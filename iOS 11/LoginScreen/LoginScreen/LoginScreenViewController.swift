//
//  LoginScreenViewController.swift
//  LoginScreen
//
//  Created by brian vilchez on 11/8/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import UIKit

class LoginScreenViewController: UIViewController {

    //MARK: - properties
    private var loginView: Login!
    
    
    
    //MARK: lifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    
    //MARK: - helper methods
  private func setupSubViews() {
        loginView = Login(frame: CGRect.zero)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginView)
        loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}
