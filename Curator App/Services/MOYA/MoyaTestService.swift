//
//  MoyaTestService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 26/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import Moya

enum MoyaTestService {
    case getPosts
}

extension MoyaTestService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        return "/posts"
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
        return nil
    }
}
