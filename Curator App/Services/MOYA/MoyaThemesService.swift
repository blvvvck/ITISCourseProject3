//
//  MoyaThemesService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 10/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import Moya

enum MoyaThemeService {
    case getSuggestions(Int)
    case getSuggestion(Int, Int)
    case getThemes(Int)
    case getTheme(Int, Int)
}

extension MoyaThemeService: TargetType {
    var baseURL: URL {
        return URL(string: "https://mobilelab-backend.herokuapp.com/api/v1")!
    }
    
    var path: String {
        switch self {
        case .getSuggestions(let id):
            return "curators/\(id)/suggestions"
            
        case .getSuggestion(let curatorId, let suggestionId):
            return "curators/\(curatorId)/suggestions/\(suggestionId)"
        
        case .getThemes(let id):
            return "curators/\(id)/themes"
            
        case .getTheme(let curatorId, let themeId):
            return "curators/\(curatorId)/themes/\(themeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSuggestions,
             .getSuggestion,
             .getTheme,
             .getThemes:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getSuggestions,
             .getSuggestion,
             .getThemes,
             .getTheme:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.value(forKey: "token")
        return ["Authorization":"Token \(token as! String)"]
    }
}
