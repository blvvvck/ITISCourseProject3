//
//  FinalThemeViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 18/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import Moya

class FinalThemeViewController: UIViewController {
    
    // MARK: - Nested Types
    
    enum FinalThemeControllerType {
        case finalTheme
        case editOrAddStudent
    }
    
    // MARK: - Instance Properties

    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var themeCuratorLabel: UILabel!
    @IBOutlet weak var themeStudentLabel: UILabel!
    @IBOutlet weak var themeAreaLabel: UILabel!
    @IBOutlet weak var themeCompetitionsLabel: UILabel!
    @IBOutlet weak var themeDescriptionLabel: UILabel!
    
    @IBOutlet weak var emptyStateContainerView: UIView!
    @IBOutlet weak var emptyStateView: EmptyStateView!
    
    // MARK: -
    
    var controllerType: FinalThemeControllerType = .finalTheme
    
    var theme: ThemeModel!
    var curator: Profile!
    
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
    
    private func configureNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTouchUpInside))
        
        switch self.controllerType {
        case .editOrAddStudent:
            let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(onEditButtonTouchUpInside))
            
            self.navigationItem.rightBarButtonItems = [addButton, editButton]
            
        case .finalTheme:
            
            self.navigationItem.rightBarButtonItem = addButton

        }
    }
    
    @objc
    private func onAddButtonTouchUpInside() {
        switch self.controllerType {
        case .editOrAddStudent:
            let alert = UIAlertController(title: "Хотите предложить тему?", message: "После редактирования ОК вам нужно будет выбрать студента, которому вы хотите предложить эту тему", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                let studentStoryboard = UIStoryboard(name: "Students", bundle: nil)
                let studentsVC = studentStoryboard.instantiateViewController(withIdentifier: "StudentsVC") as! StudentsTableViewController
                studentsVC.type = .addToExistingTheme
                studentsVC.theme = self.theme
                self.navigationController?.pushViewController(studentsVC, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        case .finalTheme:
            MoyaServices.themesProvider.request(.addTheme(self.theme)) { (result) in
                switch result {
                case .success(let response):
                    print("ADD THEME SUCCESS")
                    print(String(data: response.data, encoding: .utf8))
                    
                    let themeFromServer = try! response.map(ThemeModel.self)
                    
                    self.theme.id = themeFromServer.id
                    
                    if self.theme.student != nil {
                        MoyaServices.themesProvider.request(.addSuggestion(self.theme), completion: { (result) in
                            switch result {
                            case .success(let response):
                                print("SUCCESS ADD SUGGESTION AFTER THEME")
                                self.navigationController?.popToRootViewController(animated: true)
                                
                            case .failure(let error):
                                print("ERRROR ADD SUGGESTION AFTER THEME")
                            }
                        })
                    } 
//                    MoyaServices.themesProvider.request(.updateTheme(self.theme), completion: { (result) in
//                        switch result {
//                        case .success(let respone):
//                        print("UPDATE AFTER ADD THEME SUCCESS")
//                        print(String(data: response.data, encoding: .utf8))
//                        
//                        case .failure(let error):
//                            print("UPDATE AFTER ADD THEME ERROR")
//                        }
//                    })
                
                case .failure(let error):
                    print("ADD THEME ERROR")
                }
            }
        }
    }
    
    @objc
    private func onEditButtonTouchUpInside() {
        let alert = UIAlertController(title: "Хотите внести изменения?", message: "После редактирования темы все прошлые предложения по ней будут удалены", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            let editThemeVC = self.storyboard?.instantiateViewController(withIdentifier: "SuggestionThemeForStudentVC") as! SuggestionThemeForStudentViewController
            editThemeVC.controllerType = .edit
            self.navigationController?.pushViewController(editThemeVC, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func configureThemeLabels() {
//        self.themeTitleLabel.text = self.theme.title
//        self.themeCuratorLabel.text = "\(self.theme.curator.last_name!) \(self.theme.curator.name!) \(self.theme.curator.patronymic!)"
//        self.themeStudentLabel.text = "\(self.theme.student?.last_name) \(self.theme.student?.name) \(self.theme.student?.patronymic)"
//        self.themeAreaLabel.text = self.theme.subject.name
//        self.themeDescriptionLabel.text = self.theme.description
    }
    
    func apply(themeModel: ThemeModel) {
        self.theme = themeModel
        
        switch self.controllerType {
        case .editOrAddStudent:
            if isViewLoaded {
                self.showLoadingState()
                
                MoyaServices.themesProvider.request(.getTheme(MoyaServices.currentUserId, self.theme.id)) { (result) in
                    switch result {
                    case .success(let respone):
                        let themeModel = try! respone.map(ThemeModel.self)
                        self.theme = themeModel
                        
                        self.themeTitleLabel.text = self.theme.title
                        self.themeCuratorLabel.text = "\(self.theme.curator.last_name) \(self.theme.curator.name) \(self.theme.curator.patronymic)"
                        
                        if let subject = self.theme.subject {
                            self.themeAreaLabel.text = subject.name
                        } else {
                            self.themeAreaLabel.text = "Не выбрано"
                        }
                        
                        self.themeDescriptionLabel.text = self.theme.description
                        self.themeCompetitionsLabel.text = self.theme.skills!.first?.name!
                        
                        if let student = self.theme.student {
                            self.themeStudentLabel.text = "\(student.last_name) \(student.name) \(student.patronymic)"
                        } else {
                            self.themeStudentLabel.text = "Не выбран"
                        }
                        
                        var skills: String = ""
                        
                        if self.theme.skills!.first != nil {
                            self.theme.skills!.forEach( {skills.append(" \($0.name!),")} )
                            skills.removeLast()
                            self.themeCompetitionsLabel.text = skills
                        } else {
                            self.themeCompetitionsLabel.text = "Не выбрано"
                        }
                        
                        self.hideEmptyState()
                        
                    case .failure(let error):
                        print("GET THEME ERROR")
                        
                    }
                }
            }
            
        default:
            
            if isViewLoaded {
                self.themeTitleLabel.text = self.theme.title
                self.themeCuratorLabel.text = "\(self.curator.last_name) \(self.curator.name) \(self.curator.patronymic)"
                
                if let subject = self.theme.subject {
                    self.themeAreaLabel.text = subject.name
                } else {
                    self.themeAreaLabel.text = "Не выбрано"
                }

                self.themeDescriptionLabel.text = self.theme.description
                self.themeCompetitionsLabel.text = self.theme.skills!.first?.name!
                
                if let student = self.theme.student {
                    self.themeStudentLabel.text = "\(student.last_name) \(student.name) \(student.patronymic)"
                } else {
                    self.themeStudentLabel.text = "Не выбран"
                }
                
                var skills: String = ""
                
                if self.theme.skills!.first != nil {
                    self.theme.skills!.forEach( {skills.append(" \($0.name!),")} )
                    skills.removeLast()
                    self.themeCompetitionsLabel.text = skills
                } else {
                    self.themeCompetitionsLabel.text = "Не выбрано"
                }
            }
        }
    }
   
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
        self.configureThemeLabels()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.apply(themeModel: self.theme)
    }
}
