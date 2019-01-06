//
//  SettingsModel.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import RealmSwift

class SettingsModel: Object {
    
    @objc dynamic var mentor: String = ""
    @objc dynamic var link: String = ""
    @objc dynamic var sheetName: String = ""
    @objc dynamic var range: String = ""

}
