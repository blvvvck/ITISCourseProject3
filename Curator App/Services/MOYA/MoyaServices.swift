//
//  MoyaServices.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 10/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import Moya

struct MoyaServices {
    
    static let loginProvider = MoyaProvider<MoyaLoginService>()
    
    static let profileProvider = MoyaProvider<MoyaProfileService>()
    
    static let themesProvider = MoyaProvider<MoyaThemeService>()
    
    static let worksProvider = MoyaProvider<MoyaWorksService>()
    
    static let skillsProvider = MoyaProvider<MoyaSkillSerice>()
    
    static let subjectProvider = MoyaProvider<MoyaSubjectService>()
    
    static let studentsProvider = MoyaProvider<MoyaStudentService>()
    
    static let currentUserId = UserDefaults.standard.value(forKey: "user_id") as! Int
}
