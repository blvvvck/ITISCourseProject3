//
//  LoginViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 14/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import PromiseKit

class LoginViewController: UIViewController {

    // MARK: - Instance Properties
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Instance Methods
    
    @IBAction func onLogInButtonTouchUpInside(_ sender: Any) {
        guard let login = self.usernameTextField.text, let password = self.passwordTextField.text else {
            return
        }
        
        firstly {
            Services.authorizationService.authorizate(with: login, and: password)
        }.done { (isAuthorizate) in
            print("Complete authorization")
            
        }
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
