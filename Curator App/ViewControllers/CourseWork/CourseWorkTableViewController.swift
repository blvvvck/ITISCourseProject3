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
    
    fileprivate func config(cell: CourseWorkTableViewCell, for indexPath: IndexPath) {
        cell.corseWorkNameLabel.text = "iOS"
        cell.studentNameLabel.text = "Ринат"
    }
    
    fileprivate func loadCourseWorks() {
        self.showLoadingState()
        
        
        MoyaServices.worksProvider.request(.getCourseWorks(MoyaServices.currentUserId)) { (result) in
            switch result {
            case .success(let moyaResponse):
                print("WORKS SUCCESS")
                
                self.hideEmptyState()
            case .failure(let error):
                print("WORKS ERROR")
            }
        }
        
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.title = "Курсовые"
        self.title = "Курсовые"
        
        
//        let provider = MoyaProvider<MoyaTestService>()
//
//        provider.request(.getPosts) { (result) in
//            switch result {
//            case let .success(moyaResponse):
//                let encodedData = try? JSONDecoder().decode([Test].self, from: moyaResponse.data)
//                let en = try? moyaResponse.map([Test].self)
//            default:
//                return
//            }
//
//
//        }
        // Do any additional setup after loading the view.
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


struct Test: Codable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}
