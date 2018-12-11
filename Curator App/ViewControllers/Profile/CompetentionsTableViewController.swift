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
    
    // MARK: -
    
    var profileModel: Profile!
    
    var skills: [Skill] = []
    
    // MARK: - Instance Methods
    
    fileprivate func configure(cell: CompetitonTableViewCell, for indexPath: IndexPath) {
        cell.competitionNameLabel.text = self.skills[indexPath.row].name!
        cell.competitionLevelLabel.text = "Уровень: высокий"
    }
    
    func apply(profileModel: Profile) {
        self.profileModel = profileModel
        
        MoyaServices.skillsProvider.request(.getCuratorSkills(MoyaServices.currentUserId)) { (result) in
            switch result {
            case .success(let response):
                self.skills = try! response.map([Skill].self)
                self.tableView.reloadData()
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
        
        self.apply(profileModel: self.profileModel)
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
