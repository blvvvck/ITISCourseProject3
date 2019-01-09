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
    
    fileprivate enum Segues {
        
        static let showFilters = "ShowFilters"
    }
    
    enum StudentsControllerType {
        case usual
        case addTheme
        case addToExistingTheme
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    
    var students: [Profile] = []
    var fullStudens: [Profile] = []
    
    var isFilteredByFilter: Bool = false
    
    var theme: ThemeModel!
    
    // MARK: -
    
    var type: StudentsControllerType = .usual
    
    var onStudentSelected: ((_ student: Profile) -> Void)?
    
    // MARK: - Empty State
    
    @IBAction func onFiltersTouchUpInside(_ sender: Any) {
        let filtresVC = self.storyboard?.instantiateViewController(withIdentifier: "FiltersVC") as! StudentFilterViewController
        
        filtresVC.students = self.fullStudens
        filtresVC.fullStudents = self.fullStudens
        
        filtresVC.onDoneClicked = { [unowned self] students in
            self.isFilteredByFilter = true
            print("HETE DONE CLICKED")
            print(students)
            self.students = students
            self.tableView.reloadData()
        }
        
        filtresVC.onResetClicked = { [unowned self] in
            self.students = self.fullStudens
            self.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(filtresVC, animated: true)
    }
    
    
    fileprivate func showEmptyState(image: UIImage? = nil, title: String, message: String, action: EmptyStateAction? = nil) {
        self.emptyStateView.hideActivityIndicator()
        
        self.emptyStateView.image = image
        self.emptyStateView.title = title
        self.emptyStateView.message = message
        self.emptyStateView.action = action
        
        self.emptyStateContainerView.isHidden = false
    }
    
    fileprivate func hideEmptyState() {
        self.emptyStateContainerView.isHidden = true
    }
    
    fileprivate func showNoDataState() {
        self.showEmptyState(image: #imageLiteral(resourceName: "NoDataStateIcon.pdf"),
                            title: "No data for display",
                            message: "We are already working on correcting this error.")
    }
    
    fileprivate func showLoadingState() {
        if self.emptyStateContainerView.isHidden {
            self.showEmptyState(title: "Loading...",
                                message: "We are loading profile information. Please wait a bit.")
        }
        
        self.emptyStateView.showActivityIndicator()
    }
    
    fileprivate func handle(stateError error: Error, retryHandler: (() -> Void)? = nil) {
        //        let action = EmptyStateAction(title: "Try again".localized(), onClicked: {
        //            retryHandler?()
        //        })
        //
        //        switch error as? WebError {
        //        case .some(.connection), .some(.timeOut):
        //            if self.presets.isEmpty {
        //                self.showEmptyState(image: #imageLiteral(resourceName: "NoConnectionStateIcon.pdf"),
        //                                    title: "No internet connection".localized(),
        //                                    message: "We couldn’t connect to the server. Please check your internet connection and try again.".localized(),
        //                                    action: action)
        //            }
        //
        //        default:
        //            if self.presets.isEmpty {
        //                self.showEmptyState(image: #imageLiteral(resourceName: "ErrorStateIcon.pdf"),
        //                                    title: "Ooops! Something went wrong".localized(),
        //                                    message: "We are already working on correcting this error.".localized(),
        //                                    action: action)
        //            }
        //        }
    }
    
    // MARK: - Instance Methods
    
    fileprivate func configure(cell: StudentTableViewCell, for indexPath: IndexPath) {
        cell.studentSurnameLabel.text = self.students[indexPath.row].last_name
        cell.studentNameLabel.text = self.students[indexPath.row].name
        cell.studentLastNameLabel.text = self.students[indexPath.row].patronymic
        
        if let groupName = self.students[indexPath.row].group?.name, let courseNumber = self.students[indexPath.row].course_number {
            cell.studentGroupLabel.text = groupName
            cell.studentCourseLabel.text = "\(String(courseNumber)) курс"
        }
//
//        cell.studentGroupLabel.text = self.students[indexPath.row].group?.name
//
//
//        cell.studentCourseLabel.text = (String) self.students[indexPath.row].course_number!
    }
    
    fileprivate func loadStudents() {
        self.showLoadingState()
        
        MoyaServices.studentsProvider.request(.getStudents) { (result) in
            switch result {
            case .success(let response):
                let studentsModel = try! response.map([Profile].self)
                
                if !self.isFilteredByFilter {
                    self.students = studentsModel
                }
                self.fullStudens = studentsModel
                self.tableView.reloadData()
                
                self.hideEmptyState()
                
            case .failure(let error):
                print("ERROR GET STUDENTS")
            }
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadStudents()
    }
}

// MARK: - UITableViewDataSourse

extension StudentsTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
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
            studentProfileVC.theme = self.theme
            studentProfileVC.student = self.students[indexPath.row]
            
            studentProfileVC.onStudentSelected = { [unowned self] student in
                self.onStudentSelected?(student)
                self.navigationController?.popViewController(animated: true)
                //self.navigationController?.popViewController(animated: true)
            }
        
        case .addToExistingTheme:
            studentProfileVC.type = .addToExistingTheme
            studentProfileVC.theme = self.theme
            studentProfileVC.student = self.students[indexPath.row]
        }
        
        
        self.navigationController?.pushViewController(studentProfileVC, animated: true)
    }
}
