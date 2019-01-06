//
//  DbManagerImplementation.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import RealmSwift

class DbManagerImplementation: DbManager {
    
    var database: Realm
    let defaultMentor = ""
    let defaultLink = ""
    let defaultSheetName = ""
    let defaultRange = ""
    
    init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> SettingsModel? {
        let results: Results<SettingsModel> = database.objects(SettingsModel.self)
        return results.first
    }
    
    func addData(object: SettingsModel) {
        if let currentSettings = getDataFromDB() {
            try! database.write {
                currentSettings.mentor = object.mentor
                currentSettings.link = object.link
                currentSettings.sheetName = object.sheetName
                currentSettings.range = object.range
            }
        } else {
            try! database.write {
                database.add(object)
                print("Added new object")
            }
        }
    }
    
    func deleteAllFromDatabase() {
        try!   database.write {
            database.deleteAll()
        }
    }
    
    func getDefaultDataFromDB() -> SettingsModel {
        let defaultSettingsModel = SettingsModel(value: ["mentor": defaultMentor, "link": defaultLink, "sheetName": defaultSheetName, "range": defaultRange ])
        return defaultSettingsModel
    }
}
