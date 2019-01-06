//
//  SettingsInteractorInput.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol SettingsInteractorInput: class {
    
    func loadSettings()
    func saveSettings(with mentor: String, and link: String, and sheetName: String, and range: String)
}
