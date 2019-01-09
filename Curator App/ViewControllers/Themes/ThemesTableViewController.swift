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
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    var fullThemes: [ThemeModel] = []
    var themes: [ThemeModel] = []
    
    var suggestions: [SuggestionModel] = []
    var fullSuggestions: [SuggestionModel] = []
    
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
                let action = EmptyStateAction(title: "Try again", onClicked: {
                    retryHandler?()
                })
        
        self.showEmptyState(image: nil,
                            title: "Ooops! Something went wrong",
                            message: "We are already working on correcting this error.",
                            action: action)
        
//                switch error as? WebError {
//                case .some(.connection), .some(.timeOut):
//                    if self.themes.isEmpty {
//                        self.showEmptyState(image: #imageLiteral(resourceName: "NoConnectionStateIcon.pdf"),
//                                            title: "No internet connection",
//                                            message: "We couldn’t connect to the server. Please check your internet connection and try again.",
//                                            action: action)
//                    }
//        
//                default:
//                    if self.themes.isEmpty {
//                        self.showEmptyState(image: #imageLiteral(resourceName: "ErrorStateIcon.pdf"),
//                                            title: "Ooops! Something went wrong",
//                                            message: "We are already working on correcting this error.",
//                                            action: action)
//                    }
//                }
    }
    
    // MARK: - Instance Methods
    
    @IBAction func onSegmentedControlValueChanged(_ sender: Any) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            self.navigationItem.rightBarButtonItem = nil
            self.loadSuggestions()
            self.tableView.reloadData()
            self.searchBar.text = ""

        case 1:
            self.configureNavigationBar()
            self.loadThemes()
            self.tableView.reloadData()
            self.searchBar.text = ""
       
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
            
            if let progressTitle = self.suggestions[indexPath.row].progress?.title {
                cell.themeNameLabel.text = progressTitle
            } else {
                cell.themeNameLabel.text = self.suggestions[indexPath.row].theme.title
            }
            
            cell.themeStudentLabel.text = "\(self.suggestions[indexPath.row].student!.last_name) \(self.suggestions[indexPath.row].student!.name) \(self.suggestions[indexPath.row].student!.patronymic)"
            
            cell.themeStatusLabel.text = ThemeStatusesHelper.shared.getCorrectStatus(from:              self.suggestions[indexPath.row].status.name)
            
            cell.themeStatusLabel.isHidden = false
            cell.themeStudentLabel.isHidden = false
            
        case 1:
            cell.themeNameLabel.text = self.themes[indexPath.row].title
            
            if let lastName = self.themes[indexPath.row].student?.last_name {
                cell.themeStudentLabel.text = "\(lastName) \(self.themes[indexPath.row].student!.name) \(self.themes[indexPath.row].student!.patronymic)"
            } else {
                cell.themeStudentLabel.text = "Студент не выбран"
            }
            
            cell.themeStatusLabel.text = "Статус"
            cell.themeStatusLabel.isHidden = true
            cell.themeStudentLabel.isHidden = false

        default:
            return
        }
    }
    
    fileprivate func loadThemes() {
        self.showLoadingState()
        
        MoyaServices.themesProvider.request(.getThemes(MoyaServices.currentUserId)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let themeModel = try! moyaResponse.map([ThemeModel].self)
                self.themes = themeModel
                self.fullThemes = self.themes
                
                self.tableView.reloadData()
                
                self.hideEmptyState()
            case let .failure(error):
                print("THEMES ERROR")
                self.handle(stateError: error, retryHandler: { [weak self] in
                    self?.loadThemes()
                })
            }
        }
    }
    
    fileprivate func loadSuggestions() {
        self.showLoadingState()
        
        MoyaServices.themesProvider.request(.getSuggestions(MoyaServices.currentUserId)) { (result) in
            switch result {
            case .success(let response):
                let suggestions = try! response.map([SuggestionModel].self)
                self.suggestions = suggestions
                self.fullSuggestions = self.suggestions
                
                self.tableView.reloadData()
                
                self.hideEmptyState()
            case .failure(let error):
                print("ERROR GET SUGGESTIONS")
                self.handle(stateError: error, retryHandler: { [weak self] in
                    self?.loadSuggestions()
                })
            }
        }
    }
       
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 160
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadSuggestions()
        self.loadThemes()
        

    }
}

// MARK: - UITableViewDataSource

extension ThemesTableViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            return self.suggestions.count
            
        case 1:
            return self.themes.count
            
        default:
            return 0
        }
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
            return 115
        default:
            return 0
        }
        
        //return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            let themeSuggestionController = self.storyboard?.instantiateViewController(withIdentifier: "ThemeSuggestionVC") as! ThemeSuggestionViewController
            
            themeSuggestionController.suggestionId = self.suggestions[indexPath.row].id
    
            self.navigationController?.pushViewController(themeSuggestionController, animated: true)
        
        case 1:
            let finalThemeController = self.storyboard?.instantiateViewController(withIdentifier: "finalThemeVC") as! FinalThemeViewController
            finalThemeController.controllerType = .editOrAddStudent
            finalThemeController.theme = self.themes[indexPath.row]
            self.navigationController?.pushViewController(finalThemeController, animated: true)

        default:
            return
        }
    }
}

// MARK: - UISearchBarDelegate

extension ThemesTableViewController: UISearchBarDelegate {
    
    // MARK: - Instance Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            if searchText == "" {
                self.suggestions = self.fullSuggestions
                self.tableView.reloadData()
            } else {
                self.suggestions = self.suggestions.filter({ (suggestion) -> Bool in
                    return suggestion.theme.title.lowercased().contains(searchText.lowercased()) ||
                    suggestion.student!.last_name.lowercased().contains(searchText.lowercased()) || suggestion.student!.name.lowercased().contains(searchText.lowercased()) || suggestion.student!.patronymic.lowercased().contains(searchText.lowercased())
                })
            
                self.tableView.reloadData()
            }
            
        case 1:
            if searchText == "" {
                self.themes = self.fullThemes
                self.tableView.reloadData()
            } else {
                self.themes = self.themes.filter({ (theme) -> Bool in
                    return theme.title.lowercased().contains(searchText.lowercased())
                })
                
                self.tableView.reloadData()
            }
            
        default:
            break
        }
    }
}
