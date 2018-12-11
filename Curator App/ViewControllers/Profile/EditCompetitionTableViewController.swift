//
//  EditCompetitionTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 31/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class EditCompetitionTableViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let editCompetitionCellIdentifier = "editCompetitionIdentifier"
    }
    
    enum EditCompetitionType {
        case profile
        case addTheme
    }
    
    // MARK: - Instance Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var skills: [Skill]?
    
    var selectedSkills: [Skill] = []
    
    var profileModel: Profile!
    
    // MARK: -
    
    var type: EditCompetitionType!
    
    var onThemeSelected: ((_ name:String, _ type: String) -> Void)?
    
    var name: String!
    var typeC: String!
    
    // MARK: - Instance Methods
    
    fileprivate func configure(cell: EditCompetitionTableViewCell, for indexPath: IndexPath) {
        switch self.type {
        case .profile?:
            cell.competitionNameLabel.text = self.skills?[indexPath.row].name!
            cell.highLevelButton.isSelected = true
            
        case .addTheme?:
            cell.competitionNameLabel.text = "iOS"
            cell.highLevelButton.isSelected = true
        
        case .none:
            cell.competitionNameLabel.text = self.skills?[indexPath.row].name!
            cell.highLevelButton.isSelected = true
            
            self.profileModel.skills?.forEach({ (skill) in
                if skill.id == self.skills?[indexPath.row].id {
                    cell.accessoryType = .checkmark
                }
            })
        }
    }
    
    fileprivate func configureNavigationBar() {
        
        switch self.type {
        case .addTheme?:
            self.navigationItem.rightBarButtonItem = nil
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
            
            self.navigationItem.rightBarButtonItems = [doneButton]
        
        case .profile?:
            return
            
        default:
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
            
            self.navigationItem.rightBarButtonItems = [doneButton]
        }
    }
    
    @objc
    private func onDoneButtonTouchUpInside() {
        switch self.type {
        case .addTheme?:
            self.onThemeSelected?(self.name, self.typeC)
            self.navigationController?.popViewController(animated: true)
            
        default:
            self.profileModel.skills = self.selectedSkills
            MoyaServices.profileProvider.request(.changeProfileInfo(self.profileModel)) { (result) in
                switch result {
                case .success(let moyaResponse):
                    self.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    print("UPDATE PROFILE ERROR")
                }
            }
        }
        
    }
    
    fileprivate func loadSkills() {
        MoyaServices.skillsProvider.request(.getSkills) { (result) in
            switch result {
            case .success(let moyaResponse):
                let skills = try! moyaResponse.map([Skill].self)
                self.skills = skills
                self.tableView.reloadData()

                
            case .failure(let error):
                print("GET SKILLS ERROR")
            }
        }
    }
    
    fileprivate func loadCuratorModel() {
        MoyaServices.profileProvider.request(.getProfileInfo(MoyaServices.currentUserId)) { (result) in
            switch result {
            case .success(let moyaResponse):
                let profileModel = try! moyaResponse.map(Profile.self)
                self.profileModel = profileModel
                
                self.loadSkills()
                
            case .failure(let error):
                print("GET PROFILE INFO FAIL")
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
        
        //self.loadSkills()
        self.loadCuratorModel()
    }
}

// MARK: - UITableViewDataSource

extension EditCompetitionTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.skills?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.editCompetitionCellIdentifier, for: indexPath)
        
        self.configure(cell: cell as! EditCompetitionTableViewCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EditCompetitionTableViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        switch self.type {
        case .profile?:
            return
        case .addTheme?:
            let cell = self.tableView.cellForRow(at: indexPath) as! EditCompetitionTableViewCell
            
            if (cell.accessoryType == .none) {
                cell.accessoryType = .checkmark
                self.name = cell.competitionNameLabel.text!
                self.typeC = cell.returnLevelSelectedButton()
            } else {
                cell.accessoryType = .none
                self.name = nil
                self.typeC = nil
            }
            //self.onThemeSelected?(cell.competitionNameLabel.text!, cell.returnLevelSelectedButton())
            //self.navigationController?.popViewController(animated: true)
        
        default:
            let cell = self.tableView.cellForRow(at: indexPath) as! EditCompetitionTableViewCell
            
            if (cell.accessoryType == .none) {
                cell.accessoryType = .checkmark
                self.selectedSkills.append(self.skills![indexPath.row])
            } else {
                cell.accessoryType = .none
                self.selectedSkills.removeAll(where: {$0.id == self.skills![indexPath.row].id})
            }
            
            print(self.selectedSkills)
        }
    }
}
