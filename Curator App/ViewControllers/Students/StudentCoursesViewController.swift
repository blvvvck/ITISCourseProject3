//
//  StudentCoursesViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 08/01/2019.
//  Copyright © 2019 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class StudentCoursesViewController: UIViewController {
    
    fileprivate enum Constants {
        
        static let cellIdentifier = "studentCourseCellIdentifier"
    }

    var courses = ["1 курс", "2 курс", "3 курс", "4 курс", "Любой"]
    
    var onCourseClicked: ((_ course: String) -> Void)?
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension StudentCoursesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = self.courses[indexPath.row]
        
        return cell
    }
    
    
}

extension StudentCoursesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onCourseClicked?(self.courses[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
