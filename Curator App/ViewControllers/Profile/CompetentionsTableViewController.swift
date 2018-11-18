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
    
    // MARK: - Instance Methods
    
    fileprivate func configure(cell: CompetitonTableViewCell, for indexPath: IndexPath) {
        cell.competitionNameLabel.text = "iOS"
        cell.competitionLevelLabel.text = "Уровень: высокий"
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - UITableViewDataSorce

extension CompetentionsTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
