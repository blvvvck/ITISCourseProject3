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
    
    // MARK: -
    
    var profileModel: Profile!
    
    // MARK: - Instance Methods
    
    @IBAction func onCourseWorkButtonTouchUpInside(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2
    }
    
    // MARK: -
    
    fileprivate func loadProfileInfo() {
        let provider = MoyaProvider<MoyaProfileService>()
        
        provider.request(.getProfileInfo(UserDefaults.standard.value(forKey: "user_id") as! Int)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let profileModel = try! moyaResponse.map(Profile.self)
                
                self.profileModel = profileModel
                
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
           
            competitionVC.apply(profileModel: self.profileModel)
            
        default:
            return
        }
    }
}
