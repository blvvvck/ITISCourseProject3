//
//  ThemesTableViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 31/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class ThemesTableViewController: UIViewController {

    // MARK: - Nested Tyes
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let themeCellIdentifier = "themeTableCellIdentifier"
    }
    
    // MARK: - Instance Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - Instance Methods
    
    @IBAction func onSegmentedControlValueChanged(_ sender: Any) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.navigationItem.rightBarButtonItem = nil
            self.tableView.reloadData()

        case 1:
            self.configureNavigationBar()
            self.tableView.reloadData()

       
        default:
            return
        }
        
        //self.tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            let editButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onEditButtonTouchUpInside))
            self.navigationItem.rightBarButtonItem = editButton
        case 1:
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTouchUpInside))
            self.navigationItem.rightBarButtonItem = addButton
        default:
            return
        }
    }
    
    @objc
    private func onAddButtonTouchUpInside() {
        let createTheme = UIStoryboard.init(name: "Themes", bundle: nil).instantiateViewController(withIdentifier: "SuggestionThemeForStudentVC")
        self.navigationController?.pushViewController(createTheme, animated: true)
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        let editThemeVC = UIStoryboard.init(name: "Themes", bundle: nil).instantiateViewController(withIdentifier: "editThemeVC") as! EditThemeViewController
        self.navigationController?.pushViewController(editThemeVC, animated: true)
    }
    
    fileprivate func configure(cell: ThemeTableViewCell, for indexPath: IndexPath) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            cell.themeNameLabel.text = "Приложение для генерации отзывов"
            cell.themeStudentLabel.text = "Студент"
            cell.themeStatusLabel.text = "Статус"
            
        case 0:
            cell.themeNameLabel.text = "Приложение для генерации отзывов"
            cell.themeStudentLabel.text = "Студент"
            cell.themeStatusLabel.text = "Статус"
            cell.themeStatusLabel.isHidden = true
            cell.themeStudentLabel.isHidden = true
        default:
            return
        }
    }
       
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 160
    }
}

// MARK: - UITableViewDataSource

extension ThemesTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.themeCellIdentifier, for: indexPath)
        
        self.configure(cell: cell as! ThemeTableViewCell, for: indexPath)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension ThemesTableViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            return 170
            
        case 1:
            return 60
        default:
            return 0
        }
        
        //return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            let themeSuggestionController = self.storyboard?.instantiateViewController(withIdentifier: "ThemeSuggestionVC")
            self.navigationController?.pushViewController(themeSuggestionController!, animated: true)
            
        case 1:
            let finalThemeController = self.storyboard?.instantiateViewController(withIdentifier: "finalThemeVC") as! FinalThemeViewController
            finalThemeController.controllerType = .editOrAddStudent
            self.navigationController?.pushViewController(finalThemeController, animated: true)

        default:
            return
        }
    }
}
