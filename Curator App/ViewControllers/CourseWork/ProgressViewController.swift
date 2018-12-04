//
//  ProgressViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 20/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let progressCellIdentifier = "progressTableViewCellIdentifier"
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Instance Mehtods
    
    fileprivate func config(cell: ProgressTableViewCell, for indexPath: IndexPath) {
        cell.stepNameLabel.text = "Закончить приложение"
        cell.stepDateLabel.text = "01.01.2021"
    }
    
    fileprivate func configureNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTouchUpInside))
        
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func onAddButtonTouchUpInside() {
        let createStepVC = self.storyboard?.instantiateViewController(withIdentifier: "createCourseWorkStepVC")
        self.navigationController?.pushViewController(createStepVC!, animated: true)
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
        // Do any additional setup after loading the view.
    }
}

// MARK: - UITableViewDataSource

extension ProgressViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.progressCellIdentifier, for: indexPath)
        
        self.config(cell: cell as! ProgressTableViewCell, for: indexPath)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ProgressViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailStepVC = self.storyboard?.instantiateViewController(withIdentifier: "detailWorkStepVC") as! DetailWorkStepViewController
        
        detailStepVC.type = DetailWorkStepViewController.DetailWorkStepControllerType.watch
        
        self.navigationController?.pushViewController(detailStepVC, animated: true)
        
//        self.tableView.deselectRow(at: indexPath, animated: true)
//
//        let cell = self.tableView.cellForRow(at: indexPath)
//
//        if (cell?.accessoryType == .checkmark) {
//            cell?.accessoryType = .none
//        } else {
//            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
    }
}
