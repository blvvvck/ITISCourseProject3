//
//  Student.swift
//  CourseProject
//
//  Created by BLVCK on 03/05/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import RealmSwift

class Student: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var group: String = ""
    @objc dynamic var theme: String = ""
    @objc dynamic var course: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var isCompleted: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Student.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
