//
//  ModuleInput.swift
//  CourseProject
//
//  Created by BLVCK on 19/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

/// Send data through this protocol
protocol ModuleInput: class {
    
    /// Setting data to input module
    ///
    /// - Parameter data: anything data
    func setData(_ data: Any?)
    
}
