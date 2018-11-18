//
//  AboutMyselfViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 17/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class AboutMyselfViewController: UIViewController {

    // MARK: - Instance Properies
    
    @IBOutlet weak var aboutMyselfTextView: UITextView!
    
    // MARK: - Instance Methods
    
    @IBAction func onCancelButtonTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneButtonTouchUpInside(_ sender: Any) {
        //запрос на сохранение
        
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: -
    
    fileprivate func configureDesign() {
        self.navigationItem.title = "О себе"
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDesign()
    }
    
    
}
