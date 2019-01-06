//
//  CourseInteractorOutput.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol CourseInteractorOutput:class {
    
    func didFinishGetStudents(with models: [CellModelImplementation])
}
