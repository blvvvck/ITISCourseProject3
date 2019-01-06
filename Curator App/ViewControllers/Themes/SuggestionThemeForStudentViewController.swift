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
    var curator: Profile!
    
    var selectedStudent: Profile? = nil
    
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
        
        studentsVC.onStudentSelected = { [unowned self] student in
            self.selectedStudentButton.setTitle("\(student.last_name) \(student.name)", for: .normal)
            
            self.selectedStudent = student
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
            if self.themeNameTextField.text == "" || self.themeDescriptionTextField.text == "" ||
                self.competitonsLabel.text == "" || self.selectedSkills.count == 0 {
                // create the alert
                let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, заполните все поля", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            
            
            var themeModel: ThemeModel = ThemeModel(id: 1, title: self.themeNameTextField.text!, description: self.themeDescriptionTextField.text!, date_creation: "", date_acceptance: "", curator: Profile(id: MoyaServices.currentUserId, name: "", last_name: "", patronymic: "", description: "", skills: nil), student: self.selectedStudent, subject: self.selectedSubject, skills: self.selectedSkills)
            
            themeModel.title = self.themeNameTextField.text!
            themeModel.description = self.themeDescriptionTextField.text!
            themeModel.skills = self.selectedSkills
            themeModel.subject = self.selectedSubject
            themeModel.curator.id = MoyaServices.currentUserId
            
            let finalThemeVC = self.storyboard?.instantiateViewController(withIdentifier: "finalThemeVC") as! FinalThemeViewController
            
            finalThemeVC.controllerType = .finalTheme
            finalThemeVC.curator = self.curator
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
        
        MoyaServices.profileProvider.request(.getProfileInfo(MoyaServices.currentUserId)) { (result) in
            switch result {
            case .success(let response):
                let curatorProfile = try! response.map(Profile.self)
                self.curator = curatorProfile
                
            case .failure(let error):
                print("GET PROFILE INFO FAILURE")
            }
        }
    }
}
