//
//  MoyaWorksService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 10/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import Moya

enum MoyaWorksService {
    case getCourseWorks(Int)
    case getWorkSteps(Int)
}

extension MoyaWorksService: TargetType {
    var baseURL: URL {
        return URL(string: "https://mobilelab-backend.herokuapp.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .getCourseWorks(let id):
            return "curators/\(id)/works"
        
        case .getWorkSteps(let id):
            return "works/\(id)/steps"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseWorks,.getWorkSteps:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCourseWorks, .getWorkSteps:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.value(forKey: "token")
        return ["Authorization":"Token \(token as! String)"]
    }
}
