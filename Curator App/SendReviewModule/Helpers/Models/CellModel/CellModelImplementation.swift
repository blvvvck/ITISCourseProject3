//
//  CellModelImplementation.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class CellModelImplementation: CellModel {
   
    var id: Int
    var name: String
    var group: String
    var theme: String
    var course: String
    var email: String
    var isCompleted: Bool
    
    init(id: Int, name: String, group: String, theme: String, course: String, email: String, isCompleted: Bool) {
        self.id = id
        self.name = name
        self.group = group
        self.theme = theme
        self.course = course
        self.email = email
        self.isCompleted = isCompleted
    }
}
