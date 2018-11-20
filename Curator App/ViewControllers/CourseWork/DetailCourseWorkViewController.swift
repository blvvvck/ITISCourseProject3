//
//  DetailCourseWorkViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 20/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class DetailCourseWorkViewController: UIViewController {

    // MARK: - Instance Properties
    
    // MARK: - Instance Methods
    
    @IBAction func onProgressButtonTouchUpInside(_ sender: Any) {
        let progressVC = self.storyboard?.instantiateViewController(withIdentifier: "progressVC")
        self.navigationController?.pushViewController(progressVC!, animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
