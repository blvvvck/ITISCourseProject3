//
//  StudentsTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 28/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class StudentsTableViewController: UIViewController {

    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let studentCellIdentifier = "studentCellIdentifier"
    }
    
    enum StudentsControllerType {
        case usual
        case addTheme
        case addToExistingTheme
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    
    var type: StudentsControllerType = .usual
    
    var onStudentSelected: ((_ surname: String) -> Void)?
    
    // MARK: - Instance Methods
    
    fileprivate func configure(cell: StudentTableViewCell, for indexPath: IndexPath) {
        cell.studentSurnameLabel.text = "Surname"
        cell.studentNameLabel.text = "Name"
        cell.studentLastNameLabel.text = "LastName"
        cell.studentGroupLabel.text = "11-604"
        cell.studentCourseLabel.text = "3 курс"
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - UITableViewDataSourse

extension StudentsTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.studentCellIdentifier, for: indexPath)
       
        self.configure(cell: cell as! StudentTableViewCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StudentsTableViewController: UITableViewDelegate {
    
    // MARK: - InstanceMethods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "StudentProfileVC") as! StudentProfileViewController
        
        switch self.type {
        case .usual:
            studentProfileVC.type = .usual
            
        case .addTheme:
            studentProfileVC.type = .addTheme
            studentProfileVC.onStudentSelected = { [unowned self] in
                self.onStudentSelected?("Surname")
                self.navigationController?.popViewController(animated: true)
            }
        
        case .addToExistingTheme:
            studentProfileVC.type = .addToExistingTheme
        }
        
        
        self.navigationController?.pushViewController(studentProfileVC, animated: true)
    }
}
