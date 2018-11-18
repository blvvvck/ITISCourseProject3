//
//  FinalThemeViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 18/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

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
    
    // MARK: -
    
    var controllerType: FinalThemeControllerType = .finalTheme
    
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
                let editThemeVC = self.storyboard?.instantiateViewController(withIdentifier: "SuggestionThemeForStudentVC") as! SuggestionThemeForStudentViewController
                self.navigationController?.pushViewController(editThemeVC, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        case .finalTheme:
            self.navigationController?.popToRootViewController(animated: true)
            
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
   
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
    }
}
