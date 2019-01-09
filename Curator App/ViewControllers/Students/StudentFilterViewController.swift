//
//  StudentFilterViewController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 08/01/2019.
//  Copyright © 2019 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class StudentFilterViewController: UIViewController {
    
    fileprivate enum Segues {
        
        static let showCourses = "ShowCourses"
        static let showCompetititons = "ShowCompetitions"
    }

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var competitionsLabel: UILabel!
    
    var students: [Profile] = []
    var fullStudents: [Profile] = []
    
    var selectedSkills: [Skill] = []
    
    var onDoneClicked: ((_ students: [Profile]) -> Void)?
    var onResetClicked: (() -> Void)?
    
    private func configureNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneButtonTouchUpInside))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func onDoneButtonTouchUpInside() {
        
        switch self.courseLabel.text {
        case "1 курс":
            self.students = self.students.filter({$0.course_number == 1})
            
        case "2 курс":
            self.students = self.students.filter({$0.course_number == 2})

        case "3 курс":
            self.students = self.students.filter({$0.course_number == 3})

        case "4 курс":
            self.students = self.students.filter({$0.course_number == 4})

        case "Любой":
            self.students = self.fullStudents

        default:
            break
        }
        
        
        
        self.students = self.students.filter { (student) -> Bool in
            var skillsID: [Int] = []
            var selectedSkillsID: [Int] = []
        
            self.selectedSkills.forEach { (skill) in
                selectedSkillsID.append(skill.id)
            }
            
            let listSet = Set(student.skills_id ?? [])
            let findListSet = Set(selectedSkillsID)
            
            return findListSet.isSubset(of: listSet)
        }

        self.onDoneClicked?(self.students)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSelectCourseTouchUpInside(_ sender: Any) {
    }
    
    @IBAction func onSelectCompetitionsTouchUpInside(_ sender: Any) {
    }
    @IBAction func onResetButtonTouchUpInside(_ sender: Any) {
        self.onResetClicked?()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.showCourses:
            let controller = segue.destination as! StudentCoursesViewController
            
            controller.onCourseClicked = { [unowned self] course in
                self.courseLabel.text = course
            }
            
        case Segues.showCompetititons:
            let controller = segue.destination as! CompetitionsToFilterViewController
            
            controller.onDoneClicked = { [unowned self] skills in
                var skillsNames = ""
                skills.forEach({
                    skillsNames.append(" \($0.name!),")
                })
                self.competitionsLabel.text = skillsNames
                self.selectedSkills = skills
            }
            
        default:
            break
        }
        
    }

}
