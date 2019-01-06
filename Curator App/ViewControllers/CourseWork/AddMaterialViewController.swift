//
//  AddMaterialViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 17/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class AddMaterialViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var textView: UITextView!
    
    var work: CourseWork!
    var step: StepModel!
    
    // MARK: - Instance Methods
    
    fileprivate func configureNavigationBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
        
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc
    private func onDoneButtonTouchUpInside() {
        if self.textView.text != "" {
            let mateial = MaterialModel(id: 1, content: self.textView.text, step_id: 1)
            
            MoyaServices.worksProvider.request(.addStepMaterial(MoyaServices.currentUserId, self.work.id, self.step.id, mateial)) { (result) in
                switch result {
                case .success(let response):
                    print("ADD STEP MATERIAL SUCCESS")
                    print(String(data: response.data, encoding: .utf8))
                    
                    self.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    print("ERROR ADD STEP MATERIAL")
                }
            }
        }
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
        // Do any additional setup after loading the view.
    }
}
