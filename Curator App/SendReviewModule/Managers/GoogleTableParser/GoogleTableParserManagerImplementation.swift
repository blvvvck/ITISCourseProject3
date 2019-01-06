//
//  GoogleTableParserManagerImplementation.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn

class GoogleTableParserManagerImplementation: GoogleTableParserManager {
   
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    private let service = GTLRSheetsService()
    var dbManager: DbManager!
    var students = [StudentModel]()
    var studentDbManager = StudentDbManager()
    
    func getStudentByCourse(with course: String, and completionBlock: @escaping ([StudentModel]?) -> ()) {
    
        let user = GIDSignIn.sharedInstance().currentUser
        self.service.authorizer = user?.authentication.fetcherAuthorizer()

        guard let settings = dbManager.getDataFromDB() else { return }
        let spreadsheetId = settings.link
        let range = settings.range
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: range)
        let flagForParseStudents = UserDefaults.standard.bool(forKey: "isAddedStudents")
        let flagForSettings = UserDefaults.standard.bool(forKey: "isAddedSettings")
        
        guard flagForSettings == true else { return }
        let students = studentDbManager.getDataFromDB()
        
        if (flagForParseStudents == false || students.count == 0) {
            service.executeQuery(query) { [weak self] (ticket, result, error) in
                    
                
                guard let strongSelf = self else { return }
                strongSelf.students.removeAll()
                
                if error != nil {
                    print("Error: \(String(describing: error?.localizedDescription))")
                } else {
                    let castedResult = result as! GTLRSheets_ValueRange
                        
                    let rows = castedResult.values!
                    
                    for row in rows {
                        let student = StudentModel(name: row[0] as! String, group: row[1] as! String, theme: row[2] as! String, course: row[3] as! String, email: row[4] as! String)
                        
                        //REALM
                        let studentRealm = Student()
                        studentRealm.id = Student().incrementID()
                        studentRealm.name = student.name
                        studentRealm.group = student.group
                        studentRealm.theme = student.theme
                        studentRealm.course = student.course
                        studentRealm.email = student.email
                        studentRealm.isCompleted = false
                        strongSelf.studentDbManager.addData(object: studentRealm)
                        //                    let studentRealm = Student()
                        //                    studentRealm.id = studentRealm.Inc
                        //                    studentRealm.name = student.name
                        //                    studentRealm.group
                        //                    let studentRealm = Student(value: ["id": Student.,"name": student.name, "group": student.group, "theme": student.theme, "course": student.course, "email": student.email])
                        // strongSelf.studentDbManager.addData(object: studentRealm)
                        //if student.course == course {
                          //  strongSelf.students.append(student)
                        //}
                        //print(student)
                    }
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(true, forKey: "isAddedStudents")
                    }
                    completionBlock(strongSelf.students)
                }
            }
        }
    }
}
