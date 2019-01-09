//
//  ThemeSuggestionViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 06/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class ThemeSuggestionViewController: UIViewController {
    
    // MARK: - Nested Types
    
    fileprivate enum Constants {
        
        // MARK: - Instance Properties
        
        static let commentCellIdenifier = "suggestionThemeCommentCellIdentifier"
    }
    
    // MARK: - Instance Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var themeCuratorLabel: UILabel!
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var themeAreaLabel: UILabel!
    @IBOutlet weak var themeStatus: UILabel!
    @IBOutlet weak var themeCompetitions: UILabel!
    @IBOutlet weak var themeDescription: UILabel!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    @IBOutlet weak var commentLabel: UITextField!
    @IBOutlet weak var acceptThemeButton: UIButton!
    @IBOutlet weak var rejectThemeButton: UIButton!
    @IBOutlet weak var someChangesThemeButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var rejectThemeButtomToSpacerConstraint: NSLayoutConstraint!
    @IBOutlet weak var rejectThemeToSomeChangesConstraint: NSLayoutConstraint!
    // MARK: -
    
    var suggestionId: Int!
    var suggestion: SuggestionModel!
    var skills: [Skill]!
    var comments: [CommentModel] = []
    
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
        //        let action = EmptyStateAction(title: "Try again".localized(), onClicked: {
        //            retryHandler?()
        //        })
        //
        //        switch error as? WebError {
        //        case .some(.connection), .some(.timeOut):
        //            if self.presets.isEmpty {
        //                self.showEmptyState(image: #imageLiteral(resourceName: "NoConnectionStateIcon.pdf"),
        //                                    title: "No internet connection".localized(),
        //                                    message: "We couldn’t connect to the server. Please check your internet connection and try again.".localized(),
        //                                    action: action)
        //            }
        //
        //        default:
        //            if self.presets.isEmpty {
        //                self.showEmptyState(image: #imageLiteral(resourceName: "ErrorStateIcon.pdf"),
        //                                    title: "Ooops! Something went wrong".localized(),
        //                                    message: "We are already working on correcting this error.".localized(),
        //                                    action: action)
        //            }
        //        }
    }
    
    // MARK: - Instance Methods
    
    @IBAction func onAcceptThemeButtonTouchUpInside(_ sender: Any) {
        if self.suggestion.status.id == 1 || self.suggestion.status.id == 6 {
            MoyaServices.themesProvider.request(.updateSuggestion(MoyaServices.currentUserId, self.suggestion.id, 9)) { (result) in
                switch result {
                case .success(let response):
                    print("UPDATE SUGGESTION STATUS SUCCESS")

                case .failure(let error):
                    print("UPDATE SUGGESTION STATUS FAILURE")
                }
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Вы уже приняли тему", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onRejectThemeButtonTouchUpInside(_ sender: Any) {
        MoyaServices.themesProvider.request(.updateSuggestion(MoyaServices.currentUserId, self.suggestion.id, 7)) { (result) in
            switch result {
            case .success(let response):
                print("UPDATE SUGGESTION STATUS SUCCESS")
                
            case .failure(let error):
                print("UPDATE SUGGESTION STATUS FAILURE")
            }
        }
    }
    
    @IBAction func onSomeChangesThemeButtonTouchUpInside(_ sender: Any) {
        if self.suggestion.status.id == 1 || self.suggestion.status.id == 6 {
            MoyaServices.themesProvider.request(.updateSuggestion(MoyaServices.currentUserId, self.suggestion.id, 4)) { (result) in
                switch result {
                case .success(let response):
                    print("UPDATE SUGGESTION STATUS SUCCESS")
                    
                case .failure(let error):
                    print("UPDATE SUGGESTION STATUS FAILURE")
                }
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Изменения уже запрошены. Ожидание изменений", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onSendCommentButtonTouchUpInside(_ sender: Any) {
        if self.commentLabel.text == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Введите комментарий", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            let commentModel = CommentModel(id: 1, author_name: self.suggestion.theme.curator.name, content: self.commentLabel.text!, date_creation: DateService.shared.getNowDateInCorrectFormat(), step_id: 1, suggestion_id: self.suggestionId)
            
            MoyaServices.themesProvider.request(.addSuggestionComment(MoyaServices.currentUserId, self.suggestionId, commentModel)) { (result) in
                switch result {
                case .success(let response):
                    print("SUCCESS ADD SUGGESTION COMMENTS")
                    self.loadComments()
                    self.commentLabel.text = ""
                    
                case .failure(let error):
                    print("ERROR ADD SUGGESTION COMMENTS")
                }
            }
        }
    }
    
    
    fileprivate func config(cell: SuggestionThemeCommentTableViewCell, for indexPath: IndexPath) {
        cell.commentAuthorNameLabel.text = self.comments[indexPath.row].author_name
        cell.commentAuthorTextLabel.text = self.comments[indexPath.row].content
    }
    
    private func configureNavigationBar() {
        if self.suggestion.status.id == 3 {
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTouchUpInside))
            self.navigationItem.rightBarButtonItem = editButton
        }
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        let editThemeVC = UIStoryboard.init(name: "Themes", bundle: nil).instantiateViewController(withIdentifier: "editThemeVC") as! EditThemeViewController
        
        if let progressTitle = self.suggestion.progress?.title, let progressDescription = self.suggestion.progress?.description  {
            editThemeVC.themeName = progressTitle
            editThemeVC.themeDescription = progressDescription
        } else {
            editThemeVC.themeName = self.suggestion.theme.title
            editThemeVC.themeDescription = self.suggestion.theme.description
        }
        
        editThemeVC.suggestionId = self.suggestion.id
        
        self.navigationController?.pushViewController(editThemeVC, animated: true)
    }
    
    fileprivate func loadComments() {
        MoyaServices.themesProvider.request(.getSuggestionComments(MoyaServices.currentUserId, self.suggestionId)) { (result) in
            switch result {
            case .success(let response):
                print("GET SUGGESTION COMMENTS SUCCESS")
                let rawComments = try! response.map([CommentModel].self)
                self.comments = rawComments

                self.tableView.reloadData()

                self.hideEmptyState()

            case .failure(let error):
                print("ERROR GET SUGGESTION COMMENTS")
            }
        }
    }

    fileprivate func loadSuggestion() {
        self.showLoadingState()
        
        MoyaServices.themesProvider.request(.getSuggestion(MoyaServices.currentUserId, self.suggestionId)) { (result) in
            switch result {
            case .success(let response):
                print("GET SUGGESTION SUCCESS")
                
                self.suggestion = try! response.map(SuggestionModel.self)
                
                MoyaServices.skillsProvider.request(.getThemeSkills(self.suggestion.theme.id), completion: { (result) in
                    switch result {
                    case .success(let response):
                        print("SUCCESS GET SKILLS IN SUGGESTIONS")
                        self.skills = try! response.map([Skill].self)
                        
                        self.showSuggestionInfo()
                        
                        self.configureNavigationBar()
                        
                        self.hideEmptyState()
                        self.loadComments()
                        
                    case .failure(let error):
                        print("ERROR GET SKILLS IN SUGESTIONS")
                    }
                })
                
            case .failure(let error):
                print("GET SUGGESTION ERROR")
            }
        }
    }
    
    fileprivate func setupButtons() {
        if self.suggestion.status.id == 1 {
            
        }
        
        if self.suggestion.status.id == 2 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 3 {
            self.acceptThemeButton.isHidden = true
            //self.rejectThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 4 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 5 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 6 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 7 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
            self.rejectThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 8 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
            self.rejectThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 9 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
            self.rejectThemeButton.isHidden = true
        }
        
        if self.suggestion.status.id == 5 {
            self.acceptThemeButton.isHidden = true
            self.someChangesThemeButton.isHidden = true
        }
    }
    
    fileprivate func showSuggestionInfo() {
        
//        if !(self.suggestion.status.id == 6 || self.suggestion.status.id == 1) {
//            self.acceptThemeButton.isHidden = true
//            self.someChangesThemeButton.isHidden = true
//            self.rejectThemeButtomToSpacerConstraint.isActive = true
//            self.rejectThemeButtomToSpacerConstraint.priority = .defaultHigh
//            self.rejectThemeToSomeChangesConstraint.isActive = false
//            //self.rejectThemeToSomeChangesConstraint.priority = .defaultLow
//        }
        
//        self.acceptThemeButton.isHidden = true
//        self.someChangesThemeButton.isHidden = true
//        //self.rejectThemeButton.isHidden = true
//
//        if (self.suggestion.status.id == 6 || self.suggestion.status.id == 1) {
//            self.acceptThemeButton.isHidden = false
//        }
//
//        if (self.suggestion.status.id == 6 || self.suggestion.status.id == 1 || self.suggestion.status.id == 2) {
//            self.someChangesThemeButton.isHidden = false
//        }
        
        self.setupButtons()
        
        
        
        if let progressTitle = self.suggestion.progress?.title, let progressDescription = self.suggestion.progress?.description  {
            self.themeTitleLabel.text = progressTitle
            self.themeDescription.text = progressDescription
        } else {
            self.themeTitleLabel.text = self.suggestion.theme.title
            self.themeDescription.text = self.suggestion.theme.description
        }
        
        self.themeCuratorLabel.text = "\(self.suggestion.theme.curator.last_name) \(self.suggestion.theme.curator.name)"
        
        if let studentSurname = self.suggestion.student?.last_name, let studentName = self.suggestion.student?.name {
            self.studentLabel.text = "\(studentSurname) \(studentName)"
        } else {
            self.studentLabel.text = "Не выбрано"
        }
        
        if let subjectName = self.suggestion.theme.subject?.name {
            self.themeAreaLabel.text = subjectName
        } else {
            self.themeAreaLabel.text = "Не выбрано"
        }
        
        self.themeStatus.text = ThemeStatusesHelper.shared.getCorrectStatus(from: self.suggestion.status.name)
        
        var skillsNames = ""
        self.skills.forEach({
            skillsNames.append(" \($0.name!),")
        })
        self.themeCompetitions.text = skillsNames
    }
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
        if isViewLoaded {
            self.loadSuggestion()
        }
    }
}

// MARK: - UITableViewDataSource

extension ThemeSuggestionViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.commentCellIdenifier, for: indexPath)
        
        self.config(cell: cell as! SuggestionThemeCommentTableViewCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ThemeSuggestionViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
}
