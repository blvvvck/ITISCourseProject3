//
//  CourseInteractor.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class CourseInteractor: CourseInteractorInput {
    

    var presenter: CourseInteractorOutput!
    var tableParser: GoogleTableParserManager!
    var studentDbManager = StudentDbManager()
   
    func getStudentsByCourse(with course: String) {
        
        tableParser.getStudentByCourse(with: course) { (test) in
            //if let studentsCheked = students {
               // for student in studentsCheked {
                 //   let cellModel = CellModelImplementation(name: student.name, group: student.group, theme: student.theme, course: student.course, email: student.email)
                   // cellModels.append(cellModel)
                }
                //self.presenter.didFinishGetStudents(with: cellModels)
    

        
        var cellModels = [CellModelImplementation]()
        let students = studentDbManager.getStudentsByCourse(with: course)
        if let checkedStudents = students {
            for student in checkedStudents {
                let cellModel = CellModelImplementation(id: student.id, name: student.name, group: student.group, theme: student.theme, course: student.course, email: student.email, isCompleted: student.isCompleted)
                cellModels.append(cellModel)
            }
            self.presenter.didFinishGetStudents(with: cellModels)
        }
        //let students = tableParser.getStudentByCourse(with: course)
    }
}
