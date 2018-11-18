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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.title = "Курсовые"
        self.title = "Курсовые"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
