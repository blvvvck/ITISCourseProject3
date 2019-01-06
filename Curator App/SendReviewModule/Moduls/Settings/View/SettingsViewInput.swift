//
//  SettingsViewInput.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol SettingsViewInput: class {
    
    func setMentor(with mentor: String)
    func setLink(with link: String)
    func setSheetName(with sheetName: String)
    func setRange(with range: String)
    func dismisToStudent()
}
