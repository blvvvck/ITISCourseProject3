//
//  CompetitionsToFilterViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 09/01/2019.
//  Copyright © 2019 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class CompetitionsToFilterViewController: UIViewController {
    
    fileprivate enum Constants {
        
        static let cellIdentifier = "competitionsToFilterCellIdentifier"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var skills: [Skill] = []
    var selectedSkills: [Skill] = []
    
    var onDoneClicked: ((_ selectedSkills: [Skill]) -> Void)?
    
    fileprivate func loadCompetitions() {
        MoyaServices.skillsProvider.request(.getSkills) { (result) in
            switch result {
            case .success(let response):
                print("SUSCCESS GET SKILLS")
                let skillsModel = try! response.map([Skill].self)
                
                self.skills = skillsModel
        
                self.tableView.reloadData()
                
            case .failure(let error):
                print("ERRRO GET SKILLS")
            }
        }
    }
    
    private func configureNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func onDoneButtonTouchUpInside() {
        
        self.onDoneClicked?(self.selectedSkills)
        
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadCompetitions()
    }
}

extension CompetitionsToFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = self.skills[indexPath.row].name
        
        return cell
    }
}

extension CompetitionsToFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        let cell = self.tableView.cellForRow(at: indexPath)
        
        if (cell?.accessoryType.rawValue == 0) {
            cell?.accessoryType = .checkmark
            self.selectedSkills.append(self.skills[indexPath.row])
        } else {
            cell?.accessoryType = .none
            self.selectedSkills.removeAll(where: {$0.id == self.skills[indexPath.row].id})
        }
        
//        if cell?.accessoryType == .none {
//            cell?.accessoryType = .checkmark
//            self.selectedSkills.append(self.skills[indexPath.row])
//        } else {
//            cell?.accessoryType = .none
//            self.selectedSkills.remove(at: self.selectedSkills.firstIndex(where: {$0.id == self.selectedSkills[indexPath.row].id})!)
//        }
    }
}
