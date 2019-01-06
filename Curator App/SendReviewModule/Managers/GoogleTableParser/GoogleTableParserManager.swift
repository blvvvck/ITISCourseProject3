//
//  GoogleTableParserManager.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol GoogleTableParserManager {
    
    func getStudentByCourse(with course: String, and completionBlock: @escaping ([StudentModel]?) -> ())
}
