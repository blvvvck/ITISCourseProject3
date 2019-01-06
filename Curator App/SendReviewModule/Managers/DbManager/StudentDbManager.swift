//
//  StudentDbManager.swift
//  CourseProject
//
//  Created by BLVCK on 03/05/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import RealmSwift

class StudentDbManager {
    
    var database: Realm
    
    init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> Results<Student> {
        let results: Results<Student> = database.objects(Student.self)
        return results
    }
    
    func addData(object: Student) {
        try! database.write {
            database.add(object)
            print("Added new object")
        }
    }
    
    func deleteAllFromDatabase() {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func getStudentsByCourse(with course: String) -> Results<Student>? {
        let predicate = NSPredicate(format: "course BEGINSWITH [c]%@", course)
        let results = database.objects(Student.self).filter(predicate)
        return results
    }
    
    func getStudentById(with id: Int) -> Student {
        let predicate = NSPredicate(format: "id == %d", id)
        let result = database.objects(Student.self).filter(predicate).first
        return result!
    }
    
    func setStudentAsCompleted(with id: Int) {
        let predicate = NSPredicate(format: "id == %d", id)
        let result = database.objects(Student.self).filter(predicate).first
        try! database.write {
            result?.isCompleted = true
        }
    }
    
}
