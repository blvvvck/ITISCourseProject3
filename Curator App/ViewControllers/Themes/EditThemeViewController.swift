//
//  EditThemeViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 18/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class EditThemeViewController: UIViewController {

    // MARK: - Instance Properties
    
    @IBOutlet weak var themeNameTextField: UITextField!
    @IBOutlet weak var themeDescriptionTextField: UITextField!
    
    // MARK: -
    
    var themeName: String!
    var themeDescription: String!
    var suggestionId: Int!
    
    // MARK: - Instance Methods
    
    private func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onEditButtonTouchUpInside))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        if self.themeDescriptionTextField.text != "" && self.themeNameTextField.text != "" {
            MoyaServices.themesProvider.request(.updateSuggestionProgress(MoyaServices.currentUserId, self.suggestionId, self.themeNameTextField.text!, self.themeDescriptionTextField.text!)) { (result) in
                switch result {
                case .success(let response):
                    print("SUCCESS UPDATE SUGGESTION PROGRESS")
                    print(String(data: response.data, encoding: .utf8))
                
                    
                    MoyaServices.themesProvider.request(.updateSuggestion(MoyaServices.currentUserId, self.suggestionId, 5), completion: { (result) in
                        switch result {
                        case .success(let response):
                            print("SUCCESS UPDATE SUGGESTION STATUS")
                            
                        case .failure(let error):
                            print("ERROR UPDATE SUGGESTION STATUS")
                        }
                    })
                    
                    self.navigationController?.popViewController(animated: true)

                case .failure(let error):
                    print("ERROR UPDATE SUGGESTION PROGRESS")
                }
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, заполните все поля", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.themeNameTextField.text = self.themeName
        self.themeDescriptionTextField.text = self.themeDescription
    }
}
