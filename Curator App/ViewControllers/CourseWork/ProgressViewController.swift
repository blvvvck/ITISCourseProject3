//
//  ProgressViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 20/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let progressCellIdentifier = "progressTableViewCellIdentifier"
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    // MARK: -
    
    var courseWork: CourseWork!
    var workSteps: [StepModel] = []
    
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
    
    // MARK: - Instance Mehtods
    
    fileprivate func config(cell: ProgressTableViewCell, for indexPath: IndexPath) {
        cell.stepNameLabel.text = self.workSteps[indexPath.row].title
        let correctDate = DateService.shared.correctStringDate(from: self.workSteps[indexPath.row].date_finish)
        cell.stepDateLabel.text = correctDate
        
        if self.workSteps[indexPath.row].status.id == 3 {
            cell.checkBox.setOn(true, animated: false)
        } else {
            cell.checkBox.setOn(false, animated: false) 
        }
        
        cell.onCheckBoxClicked = { [unowned self] in
            
            if self.workSteps[indexPath.row].status.id == 1 {
                self.workSteps[indexPath.row].status.id = 3
            } else if self.workSteps[indexPath.row].status.id == 3 {
                self.workSteps[indexPath.row].status.id = 1
            }
        MoyaServices.worksProvider.request(.updateWorkStep(MoyaServices.currentUserId,self.courseWork.id, self.workSteps[indexPath.row]), completion: { (result) in
                switch result {
                case .success(let response):
                    print("UPDATE WORK STEP STATUS SUCCESS")
                
                case .failure(let error):
                    print("UPDATE WORK STEP STATUS ERROR")
                }
            })
        }
    }
    
    fileprivate func configureNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTouchUpInside))
        
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func onAddButtonTouchUpInside() {
        
        let detailStepVC = self.storyboard?.instantiateViewController(withIdentifier: "detailWorkStepVC") as! DetailWorkStepViewController
        
        detailStepVC.type = DetailWorkStepViewController.DetailWorkStepControllerType.add
        detailStepVC.courseWork = self.courseWork
        
        self.navigationController?.pushViewController(detailStepVC, animated: true)
    }
    
    func apply(courseWork: CourseWork) {
        self.courseWork = courseWork
        
        if isViewLoaded {
            self.showLoadingState()
            
            MoyaServices.worksProvider.request(.getWorkSteps(self.courseWork.id)) { (result) in
                switch result {
                case .success(let response):
                    let steps = try! response.map([StepModel].self)
                    self.workSteps = steps
        
                    self.tableView.reloadData()
        
                    self.hideEmptyState()
                case .failure(let error):
                    print("GET STEPS ERROR")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.apply(courseWork: self.courseWork)
    }
}

// MARK: - UITableViewDataSource

extension ProgressViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workSteps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.progressCellIdentifier, for: indexPath)
        
        self.config(cell: cell as! ProgressTableViewCell, for: indexPath)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ProgressViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailStepVC = self.storyboard?.instantiateViewController(withIdentifier: "detailWorkStepVC") as! DetailWorkStepViewController
        
        detailStepVC.type = DetailWorkStepViewController.DetailWorkStepControllerType.watch
        detailStepVC.apply(workStep: self.workSteps[indexPath.row], courseWork: self.courseWork)
        
        self.navigationController?.pushViewController(detailStepVC, animated: true)
        
//        self.tableView.deselectRow(at: indexPath, animated: true)
//
//        let cell = self.tableView.cellForRow(at: indexPath)
//
//        if (cell?.accessoryType == .checkmark) {
//            cell?.accessoryType = .none
//        } else {
//            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
    }
}
