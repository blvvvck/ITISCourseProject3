//
//  EditThemeViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 18/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class EditThemeViewController: UIViewController {

    // MARK: - Instance Properties
    
    @IBOutlet weak var themeNameTextField: UITextField!
    @IBOutlet weak var themeDescriptionTextField: UITextField!
    
    // MARK: - Instance Methods
    
    private func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onEditButtonTouchUpInside))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
        // Do any additional setup after loading the view.
    }
}
