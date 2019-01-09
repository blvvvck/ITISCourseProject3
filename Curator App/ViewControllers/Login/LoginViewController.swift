//
//  LoginViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 14/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import PromiseKit
import Moya

class LoginViewController: UIViewController {

    // MARK: - Instance Properties
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Instance Methods
    
    @IBAction func onLogInButtonTouchUpInside(_ sender: Any) {
        guard let login = self.usernameTextField.text, let password = self.passwordTextField.text else {
            return
        }
        
        UserDefaults.standard.set(login, forKey: "login")
        UserDefaults.standard.set(password, forKey: "password")
        
        let provider = MoyaProvider<MoyaLoginService>()
        provider.request(.login(login, password)) { (result) in
            switch result {
            case let .success(moyaResponse):
                
                if moyaResponse.statusCode == 200 {
                    var loginModel: LoginModel = try! moyaResponse.map(LoginModel.self)
                    
                    UserDefaults.standard.set(loginModel.token, forKey: "token")
                    UserDefaults.standard.set(loginModel.user_id, forKey: "user_id")
                    
                    if !loginModel.token.isEmpty {
                        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                        self.present(mainStoryboard.instantiateInitialViewController()!, animated: true, completion: nil)
                    }
                } else {
                    // create the alert
                    let alert = UIAlertController(title: "Ошибка", message: "Введены некоректные данные", preferredStyle: UIAlertController.Style.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            case .failure(let error):
                print("FAILURE LOGIN")
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Ошибка", message: "Ошибка сервера. Попробуйте еще раз", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }

//        if login == "login" && password == "123" {
//            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//            self.present(mainStoryboard.instantiateInitialViewController()!, animated: true, completion: nil)
//        }
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
