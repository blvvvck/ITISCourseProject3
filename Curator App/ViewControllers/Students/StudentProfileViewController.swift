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
    }
    
    // MARK: - Instance Properties
    
    var type: StudentsProfileType!
    
    var onStudentSelected: (() -> Void)?

    // MARK: - Instance Method
    
    private func configureNavigationBar() {
        switch self.type {
        case .addTheme?:
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
        self.onStudentSelected?()
        self.navigationController?.popViewController(animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        // Do any additional setup after loading the view.
    }
}
