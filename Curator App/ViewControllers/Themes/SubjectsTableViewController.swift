//
//  SubjectsTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 31/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class SubjectsTableViewController: UIViewController {

    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let subjectCellIdentifier = "subjectCellidentifier"
    }
    
    // MARK: - Intance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    let subjectList = ["iOS 1", "iOS 2", "iOS 3", "iOS 4", "iOS 5", "iOS 6", "iOS 7", "iOS 8", "iOS 9", "iOS 10"]
    
    var onCellTouchUpInside: ((_ selectedSubject: String) -> Void)?
    
    // MARK: - Instance Methods
    
    fileprivate func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        cell.textLabel?.text = self.subjectList[indexPath.row]
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

// MARK: - UITableViewDataSource

extension SubjectsTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.subjectCellIdentifier, for: indexPath)
        
        self.configure(cell: cell, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SubjectsTableViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onCellTouchUpInside?(self.subjectList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
