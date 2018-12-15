//
//  StudentProfileViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 30/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class StudentProfileViewController: UIViewController {
    
    // MARK: - Nested Type
    
    enum StudentsProfileType {
        case usual
        case addTheme
        case addToExistingTheme
    }
    
    // MARK: - Instance Properties
    
    var type: StudentsProfileType!
    
    var student: Profile!
    var theme: ThemeModel!
    
    var onStudentSelected: ((_ students: Profile) -> Void)?

    // MARK: - Instance Method
    
    private func configureNavigationBar() {
        switch self.type {
        case .addTheme?:
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTouchUpInside))
            self.navigationItem.rightBarButtonItem = addButton
            
        case .addToExistingTheme?:
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTouchUpInside))
            self.navigationItem.rightBarButtonItem = addButton
            
        default:
            return
        }
    }
    
    @objc
    private func onAddButtonTouchUpInside() {
        //let suggestionThemeForStudentVC = self.storyboard?.instantiateViewController(withIdentifier: "SuggestionThemeForStudentVC")
        //self.navigationController?.pushViewController(suggestionThemeForStudentVC!, animated: true)
        switch self.type {
        case .addTheme?:
            //self.onStudentSelected?()
            self.navigationController?.popViewController(animated: true)
            
        case .addToExistingTheme?:
            self.theme.student = self.student
            MoyaServices.themesProvider.request(.addSuggestion(self.theme)) { (result) in
                switch result {
                case .success(let respone):
                    print("ADD SUGGESTION SUCCESS")
                    print(String(data: respone.data, encoding: .utf8))
                    
                case .failure(let error):
                    print("ERROR ADD SUGGESTION")
                }
            }
            
//            self.theme.student = self.student
//            MoyaServices.themesProvider.request(.updateTheme(self.theme)) { (result) in
//                switch result {
//                case .success(let response):
//                    print("UPDATE THEME SUCCESS")
//                    print(String(data: response.data, encoding: .utf8))
//                    
//                case .failure(let error):
//                    print("UPDATE THEME ERROR")
//                }
//            }
            
            self.navigationController?.popToRootViewController(animated: true)
            
        default:
            return
        }
        
        //self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
