//
//  CourseWorkTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 23/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class CourseWorkTableViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let courseWorkCellIdentifier = "courseWorkCellIdentifier"
    }
    
    // MARK: - Intance Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    // MARK: -
    
    var courseWorks: [CourseWork] = []
    
    // MARK: - Empty State
    
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
        self.hideEmptyState()
                let action = EmptyStateAction(title: "Try again", onClicked: {
                    retryHandler?()
                })
        
        
        self.showEmptyState(image: nil,
                            title: "Ooops! Something went wrong",
                            message: "We are already working on correcting this error.",
                            action: action)
        
//                switch error as? WebError {
//                case .some(.connection), .some(.timeOut):
//                    if self.courseWorks.isEmpty {
//                        self.showEmptyState(image: #imageLiteral(resourceName: "NoConnectionStateIcon.pdf"),
//                                            title: "No internet connection",
//                                            message: "We couldn’t connect to the server. Please check your internet connection and try again.",
//                                            action: action)
//                    }
//
//                default:
//                    if self.courseWorks.isEmpty {
//                        self.showEmptyState(image: #imageLiteral(resourceName: "ErrorStateIcon.pdf"),
//                                            title: "Ooops! Something went wrong",
//                                            message: "We are already working on correcting this error.",
//                                            action: action)
//                    }
//                }
    }
    
    // MARK: - Instance Methods
    
    fileprivate func config(cell: CourseWorkTableViewCell, for indexPath: IndexPath) {
        cell.corseWorkNameLabel.text = self.courseWorks[indexPath.row].theme.title
        cell.studentNameLabel.text = "\(self.courseWorks[indexPath.row].theme.student!.last_name) \(self.courseWorks[indexPath.row].theme.student!.name) \(self.courseWorks[indexPath.row].theme.student!.patronymic)"
    }
    
    fileprivate func loadCourseWorks() {
        self.showLoadingState()
        
        
        MoyaServices.worksProvider.request(.getCourseWorks(MoyaServices.currentUserId)) { (result) in
            switch result {
            case .success(let moyaResponse):
                let courseWorks = try! moyaResponse.map([CourseWork].self)
                self.courseWorks = courseWorks
                self.tableView.reloadData()
                self.hideEmptyState()
            case .failure(let error):
                print("WORKS ERROR")
                self.handle(stateError: error, retryHandler: { [weak self] in
                    self?.loadCourseWorks()
                })
            }
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.title = "Курсовые"
        self.title = "Курсовые"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.loadCourseWorks()
    }
}

// MARK: - UITableViewDataSource

extension CourseWorkTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseWorks.count
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
        let detailCourseWorkVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailCourseWorkVC") as! DetailCourseWorkViewController
       
        detailCourseWorkVC.apply(courseWork: self.courseWorks[indexPath.row])
        
        self.navigationController?.pushViewController(detailCourseWorkVC, animated: true)
    }
}
