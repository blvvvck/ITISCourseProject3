//
//  DbManager.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import RealmSwift

protocol DbManager {
    
    func getDataFromDB() -> SettingsModel?
    func addData(object: SettingsModel)
    func deleteAllFromDatabase()
    func getDefaultDataFromDB() -> SettingsModel
}
