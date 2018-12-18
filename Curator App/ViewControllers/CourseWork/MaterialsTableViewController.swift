//
//  MaterialsTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 17/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class MaterialsTableViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Nested Properties
        
        static let materialCellIdentifier = "materialTableCellIdentifier"
    }

    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    // MARK: -
    
    var materials: [MaterialModel] = []
    var work: CourseWork!
    var step: StepModel!
    
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
    
    fileprivate func config(cell: UITableViewCell, for indexPath: IndexPath) {
        cell.textLabel?.text = self.materials[indexPath.row].content
    }
    
    fileprivate func loadMaterials() {
        self.showLoadingState()
        
        MoyaServices.worksProvider.request(.getStepMaterials(MoyaServices.currentUserId, work.id, step.id)) { (result) in
            switch result {
            case .success(let response):
                print("GET STEP MATERIALS SUCCESS")
                let materials = try! response.map([MaterialModel].self)
                self.materials = materials
                
                self.tableView.reloadData()
                
                self.hideEmptyState()
            
            case .failure(let error):
                print("ERROR GET STEP MATERIALS")
            }
        }
    }
    
    fileprivate func configureNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onEditButtonTouchUpInside))
        
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        let addMaterialVC = self.storyboard?.instantiateViewController(withIdentifier: "AddMaterialVC") as! AddMaterialViewController
        
        addMaterialVC.work = self.work
        addMaterialVC.step = self.step
        
        self.navigationController?.pushViewController(addMaterialVC, animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadMaterials()
    }
}

// MARK: - UITableViewDataSource

extension MaterialsTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.materials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.materialCellIdentifier, for: indexPath)
        
        self.config(cell: cell, for: indexPath)
        
        return cell
    }
}


// MARK: - UITableViewDelegate

extension MaterialsTableViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
