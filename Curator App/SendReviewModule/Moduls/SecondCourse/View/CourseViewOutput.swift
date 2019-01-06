//
//  CourseViewOutput.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol CourseViewOutput {
    
    func viewIsReady(with course: String)
    func didSelectStudent(with id: Int)
    
}
