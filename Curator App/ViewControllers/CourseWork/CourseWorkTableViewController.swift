//
//  CourseWorkTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 23/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class CourseWorkTableViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let courseWorkCellIdentifier = "courseWorkCellIdentifier"
    }
    
    // MARK: - Intance Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Instance Methods
    
    fileprivate func config(cell: CourseWorkTableViewCell, for indexPath: IndexPath) {
        cell.corseWorkNameLabel.text = "iOS"
        cell.studentNameLabel.text = "Ринат"
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.title = "Курсовые"
        self.title = "Курсовые"
        // Do any additional setup after loading the view.
    }
}

// MARK: - UITableViewDataSource

extension CourseWorkTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.courseWorkCellIdentifier, for: indexPath)
        
        self.config(cell: cell as! CourseWorkTableViewCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CourseWorkTableViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCourseWorkVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailCourseWorkVC")
        self.navigationController?.pushViewController(detailCourseWorkVC!, animated: true)
    }
    
}
