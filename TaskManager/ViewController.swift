//
//  ViewController.swift
//  TaskManager
//
//  Created by JojoBandung on 4/30/19.
//  Copyright © 2019 JojoBandung. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }


}

