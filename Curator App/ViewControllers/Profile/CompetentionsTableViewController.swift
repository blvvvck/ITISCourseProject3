//
//  CompetentionsTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 23/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class CompetentionsTableViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let competitionCellIdentifier = "competitionCellIdentifier"
    }

    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    
    @IBOutlet weak var emptyStateView: EmptyStateView!
    // MARK: -
    
    var profileModel: Profile!
    
    var skills: [Skill] = []
    
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
    
    fileprivate func configure(cell: CompetitonTableViewCell, for indexPath: IndexPath) {
        cell.competitionNameLabel.text = self.skills[indexPath.row].name!
        cell.competitionLevelLabel.text = "Уровень: высокий"
    }
    
    func apply() {
        //self.profileModel = profileModel
        self.showLoadingState()

        MoyaServices.skillsProvider.request(.getCuratorSkills(MoyaServices.currentUserId)) { (result) in
            
            
            switch result {
            case .success(let response):
                self.skills = try! response.map([Skill].self)
                self.tableView.reloadData()
                
                self.hideEmptyState()
            case .failure(let error):
                print("ERROR CURATOR SKILL LOAD")
            }
        }
        
        if isViewLoaded {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.apply()
    }
}

// MARK: - UITableViewDataSorce

extension CompetentionsTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.competitionCellIdentifier, for: indexPath)
        
        self.configure(cell: cell as! CompetitonTableViewCell, for: indexPath)
        
        return cell
    }
}

// MARL: - UITableViewDelegate

extension CompetentionsTableViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
