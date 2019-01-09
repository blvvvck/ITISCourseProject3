//
//  MoyaLoginService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 10/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import Moya

enum MoyaLoginService {
    case login(String, String)
    case logout(String, String)
}

extension MoyaLoginService: TargetType {
    var baseURL: URL {
        return URL(string: "https://mobilelab-backend.herokuapp.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        
        case .logout:
            return "/logout"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let login, let password):
            var parameters = [String : Any]()
            
            parameters["username"] = login
            parameters["password"] = password
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
            
        case .logout(let login, let password):
            var parameters = [String : Any]()
            
            parameters["username"] = login
            parameters["password"] = password
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
