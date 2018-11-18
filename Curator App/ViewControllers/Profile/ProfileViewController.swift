//
//  ProfileViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 16/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    // MARK: - Instance Methods
    
    @IBAction func onCourseWorkButtonTouchUpInside(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarItem.title = "Профиль"
        self.title = "Профиль"
        
        // Do any additional setup after loading the view.
    }
    

}
