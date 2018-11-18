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
    
    // MARK: - Instance Methods
    
    @IBAction func onSelectSubjectTouchUpInside(_ sender: Any) {
        let subjectsVC = self.storyboard?.instantiateViewController(withIdentifier: "SubjectsVC") as! SubjectsTableViewController
        subjectsVC.onCellTouchUpInside = { [unowned self] selectedSubject in
            self.selectedSubjectLabel.text = selectedSubject
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
        
        competitionVC.onThemeSelected = { [unowned self] title, level in
            self.competitonsLabel.text = "\(title) Уровень: \(level)"
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
            let finalThemeVC = self.storyboard?.instantiateViewController(withIdentifier: "finalThemeVC")
            self.navigationController?.pushViewController(finalThemeVC!, animated: true)
            
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
