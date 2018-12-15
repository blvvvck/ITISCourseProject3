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
    
    @IBOutlet weak var courseWorkNameLabel: UILabel!
    @IBOutlet weak var courseWorkAuthorLabel: UILabel!
    @IBOutlet weak var courseWorkCuratorLabel: UILabel!
    @IBOutlet weak var courseWorkDescription: UITextView!
    
    // MARK: -
    
    var courseWork: CourseWork!
    
    // MARK: - Instance Methods
    
    @IBAction func onProgressButtonTouchUpInside(_ sender: Any) {
        let progressVC = self.storyboard?.instantiateViewController(withIdentifier: "progressVC") as! ProgressViewController
        
        progressVC.apply(courseWork: self.courseWork)
        
        self.navigationController?.pushViewController(progressVC, animated: true)
    }
    
    func apply(courseWork: CourseWork) {
        self.courseWork = courseWork
        
        if isViewLoaded {
            courseWorkNameLabel.text = self.courseWork.theme.title
            courseWorkAuthorLabel.text = "\(self.courseWork.theme.student!.last_name) \(self.courseWork.theme.student!.name) \(self.courseWork.theme.student!.patronymic)"
            courseWorkCuratorLabel.text = "\(self.courseWork.theme.curator.last_name) \(self.courseWork.theme.curator.name) \(self.courseWork.theme.curator.patronymic)"
            courseWorkDescription.text = self.courseWork.theme.description
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.apply(courseWork: self.courseWork)
    }
}
