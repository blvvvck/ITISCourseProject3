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
    
    // MARK: -
    
    var type: EditCompetitionType!
    
    var onThemeSelected: ((_ name:String, _ type: String) -> Void)?
    
    // MARK: - Instance Methods
    
    fileprivate func configure(cell: EditCompetitionTableViewCell, for indexPath: IndexPath) {
        cell.competitionNameLabel.text = "iOS"
        cell.highLevelButton.isSelected = true
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - UITableViewDataSource

extension EditCompetitionTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        switch self.type {
        case .profile?:
            return
        case .addTheme?:
            let cell = self.tableView.cellForRow(at: indexPath) as! EditCompetitionTableViewCell
            self.onThemeSelected?(cell.competitionNameLabel.text!, cell.returnLevelSelectedButton())
            self.navigationController?.popViewController(animated: true)
        
        default:
            return
        }
    }
}
