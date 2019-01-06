//
//  CellModel.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol CellModel {
    
    var id: Int {get set}
    var name: String { get set }
    var group: String { get set }
    var theme: String { get set }
    var course: String { get set }
    var email: String { get set }
    var isCompleted: Bool { get set }
}
