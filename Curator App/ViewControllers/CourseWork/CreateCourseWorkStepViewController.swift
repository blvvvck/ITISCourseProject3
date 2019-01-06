//
//  CreateCourseWorkStepViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 28/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class CreateCourseWorkStepViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    
    
    // MARK: - Instance Methods
    
    fileprivate func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
        
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func onDoneButtonTouchUpInside() {
        // TO-DO: тут скорее всего запрос на добавление нового шага
        // А после возврата на пред экран во вью вил апире будет запрос всех шагов
        
        self.navigationController?.popViewController(animated: true)
    }
    

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
