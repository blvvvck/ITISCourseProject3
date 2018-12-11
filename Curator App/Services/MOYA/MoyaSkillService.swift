//
//  MoyaSkillService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 11/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import Moya

enum MoyaSkillSerice {
    case getSkills
    case getSkill(Int)
    case getCuratorSkills(Int)
}

extension MoyaSkillSerice: TargetType {
    var baseURL: URL {
        return URL(string: "https://mobilelab-backend.herokuapp.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .getSkills:
            return "skills"
            
        case .getSkill(let id):
            return "skills/\(id)"
            
        case .getCuratorSkills(let id):
            return "curators/\(id)/skills"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.value(forKey: "token")
        return ["Authorization":"Token \(token as! String)"]
    }
}
