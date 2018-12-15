//
//  SuggestionThemeForStudentViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 30/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class SuggestionThemeForStudentViewController: UIViewController {
    
    // MARK: - Nested Types
    
    enum SuggestionThemeForStudentControllerType {
        case final
        case edit
    }

    // MARK: - Instance Properties
    
    @IBOutlet weak var themeNameTextField: UITextField!
    @IBOutlet weak var themeDescriptionTextField: UITextField!
    @IBOutlet weak var selectedSubjectLabel: UILabel!
    @IBOutlet weak var selectedStudentButton: UIButton!
    
    @IBOutlet weak var competitonsLabel: UILabel!
    
    // MARK: -
    
    var controllerType: SuggestionThemeForStudentControllerType = .final
    
    var selectedSubject: SubjectModel!
    var selectedSkills: [Skill] = []
    
    // MARK: - Instance Methods
    
    @IBAction func onSelectSubjectTouchUpInside(_ sender: Any) {
        let subjectsVC = self.storyboard?.instantiateViewController(withIdentifier: "SubjectsVC") as! SubjectsTableViewController
        subjectsVC.onCellTouchUpInside = { [unowned self] selectedSubject in
            self.selectedSubject = selectedSubject
            self.selectedSubjectLabel.text = self.selectedSubject.name
        }
        
        self.present(subjectsVC, animated: true, completion: nil)
    }
    
    @IBAction func onSelectStudentTouchUpInside(_ sender: Any) {
        let studentStoryboard = UIStoryboard.init(name: "Students", bundle: nil)
        let studentsVC = studentStoryboard.instantiateViewController(withIdentifier: "StudentsVC") as! StudentsTableViewController
        studentsVC.type = .addTheme
        
        studentsVC.onStudentSelected = { [unowned self] surname in
            self.selectedStudentButton.setTitle(surname, for: .normal)
        }
        
        self.navigationController?.pushViewController(studentsVC, animated: true)
    }
    
    @IBAction func onAddCompetetionTouchUpInside(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Profile", bundle: nil)
        let competitionVC = storyboard.instantiateViewController(withIdentifier: "EditCompetitionVC") as! EditCompetitionTableViewController
        competitionVC.type = .addTheme
        
        competitionVC.onThemeSelected = { [unowned self] selectedSkills in
            self.selectedSkills = selectedSkills
            if selectedSkills.count > 0 {
                var skills = ""
                selectedSkills.forEach( {
                    
                    skills.append(" \($0.name!),")
                    
                })
                skills.removeLast()
                self.competitonsLabel.text = skills
            } else {
                self.competitonsLabel.text = "Не выбрано"
            }
        }
        
        self.navigationController?.pushViewController(competitionVC, animated: true)
    }
    
    private func configureNavigationBar() {
       let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTouchUpInside))
     self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func onAddButtonTouchUpInside() {
        switch controllerType {
        case .final:
            var themeModel: ThemeModel = ThemeModel(id: 1, title: self.themeNameTextField.text!, description: self.themeDescriptionTextField.text!, date_creation: "", date_acceptance: "", curator: Profile(id: 1, name: "", last_name: "", patronymic: "", description: "", skills: nil), student: nil, subject: self.selectedSubject, skills: self.selectedSkills)
            
            themeModel.title = self.themeNameTextField.text!
            themeModel.description = self.themeDescriptionTextField.text!
            themeModel.skills = self.selectedSkills
            themeModel.subject = self.selectedSubject
            themeModel.curator.id = MoyaServices.currentUserId
            
            let finalThemeVC = self.storyboard?.instantiateViewController(withIdentifier: "finalThemeVC") as! FinalThemeViewController
            
            finalThemeVC.controllerType = .finalTheme
            finalThemeVC.apply(themeModel: themeModel)
            self.navigationController?.pushViewController(finalThemeVC, animated: true)
            
        case .edit:
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
    }
}
