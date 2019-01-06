//
//  MoyaProfileService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 09/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import Moya

enum MoyaProfileService {
    case getProfileInfo(Int)
    case changeProfileInfo(Profile)
    case getCuratorSkills(Int)
}

extension MoyaProfileService: TargetType {
    var baseURL: URL {
        return URL(string: "https://mobilelab-backend.herokuapp.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .getProfileInfo(let id):
            return "curators/\(id)"
            
        case .changeProfileInfo(let profile):
            return "curators/\(profile.id)"
            
        case .getCuratorSkills(let curatorId):
            return "curators/\(curatorId)/skills"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfileInfo, .getCuratorSkills:
            return .get
        case .changeProfileInfo:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getProfileInfo, .getCuratorSkills:
            return .requestPlain
        
        case.changeProfileInfo(let profile):
            var parameters = [String: Any]()
            parameters["name"] = profile.name
            parameters["last_name"] = profile.last_name
            parameters["patronymic"] = profile.patronymic
            parameters["description"] = profile.description
            
            let skillsIds = profile.skills!.map({$0.id})
            
            parameters["skills_id"] = skillsIds
            
            //ХЗ КАКОЙ ЕНКОДИНГ // вроде норм энкодинг
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.value(forKey: "token")
        return ["Authorization":"Token \(token as! String)"]
    }
}
