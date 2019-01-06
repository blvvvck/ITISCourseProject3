//
//  ProfileViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 16/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class ProfileViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Segues {
        static let competentionSegue = "ShowCompetitions"
        static let descriptionSegue = "ShowDescription"
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var nameAndPatronymicLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    // MARK: -
    
    var profileModel: Profile!
    
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
    
    @IBAction func onCourseWorkButtonTouchUpInside(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    @IBAction func onExitButtonTouchUpInside(_ sender: Any) { let mainStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
        self.present(mainStoryboard.instantiateInitialViewController()!, animated: true, completion: nil)
    }
    // MARK: -
    
    fileprivate func loadCuratorSkills() {
        MoyaServices.profileProvider.request(.getCuratorSkills(MoyaServices.currentUserId)) { (result) in
            switch result {
            case .success(let response):
                self.profileModel.skills = try! response.map([Skill].self)  
                
                self.hideEmptyState()
            case .failure(let error):
                print("GET SKILLS CURATOR ERROR")
            }
        }
    }
    
    fileprivate func loadProfileInfo() {
        let provider = MoyaProvider<MoyaProfileService>()
        
        self.showLoadingState()
        
        provider.request(.getProfileInfo(UserDefaults.standard.value(forKey: "user_id") as! Int)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let profileModel = try! moyaResponse.map(Profile.self)
                
                self.profileModel = profileModel
                
                self.loadCuratorSkills()
                
                self.surnameLabel.text = self.profileModel.last_name
                self.nameAndPatronymicLabel.text = "\(self.profileModel.name) \(self.profileModel.patronymic)"
                self.descriptionLabel.text = self.profileModel.description
            
            case let .failure(error):
                print(error.errorDescription)
                
            default:
                return
                
            }
        }
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarItem.title = "Профиль"
        self.title = "Профиль"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadProfileInfo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case Segues.descriptionSegue:
            guard let navigationController = segue.destination as? UINavigationController else {
                return
            }
            
            let descriptionVC = navigationController.viewControllers.first! as! AboutMyselfViewController
            descriptionVC.apply(profileModel: self.profileModel)
            
        case Segues.competentionSegue:
           let competitionVC = segue.destination as! CompetentionsTableViewController
            competitionVC.profileModel = self.profileModel
           
            //competitionVC.apply(profileModel: self.profileModel)
            
        default:
            return
        }
    }
}
