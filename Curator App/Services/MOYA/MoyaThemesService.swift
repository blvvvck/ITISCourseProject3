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
    case addSuggestion(ThemeModel)
    case getThemes(Int)
    case getTheme(Int, Int)
    case addTheme(ThemeModel)
    case updateTheme(ThemeModel)
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
            
        case .addSuggestion(let themeModel):
            return "curators/\(themeModel.curator)/suggestions"
        
        case .getThemes(let id):
            return "curators/\(id)/themes"
            
        case .getTheme(let curatorId, let themeId):
            return "curators/\(curatorId)/themes/\(themeId)"
            
        case .addTheme(let themeModel):
            return "curators/\(themeModel.curator.id)/themes"
            
        case .updateTheme(let themeModel):
            return "curators/\(themeModel.curator.id)/themes/\(themeModel.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSuggestions,
             .getSuggestion,
             .getTheme,
             .getThemes:
            return .get
            
        case .addTheme, .addSuggestion:
            return .post
            
        case .updateTheme:
            return .put
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
            
        case .addSuggestion(let themeModel):
            var parameters = [String: Any]()
            parameters["date_creation"] = DateService.shared.getNowDateInCorrectFormat()
            parameters["theme"] = themeModel.id
            parameters["student"] = themeModel.student!.id
            parameters["curator"] = themeModel.curator.id
            parameters["status"] = 0
            
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .addTheme(let themeModel):
            var parameters = [String: Any]()
            parameters["title"] = themeModel.title
            parameters["description"] = themeModel.description
            parameters["date_creation"] = DateService.shared.getNowDateInCorrectFormat()
            parameters["subject"] = themeModel.subject!.id
           
            let skillsIds = themeModel.skills!.map({$0.id})
            parameters["skills"] = skillsIds
            
        
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .updateTheme(let themeModel):
            var parameters = [String: Any]()
            parameters["title"] = themeModel.title
            parameters["description"] = themeModel.description
            parameters["date_creation"] = DateService.shared.getNowDateInCorrectFormat()
            
            
            //parameters["subject"] = themeModel.subject!.id
            
            if let subject = themeModel.subject {
                parameters["subject"] = subject.id
            }
            
            let skillsIds = themeModel.skills!.map({$0.id})
            parameters["skills"] = skillsIds
            
            if let student = themeModel.student {
                parameters["student"] = student.id
            }
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.value(forKey: "token")
        return ["Authorization":"Token \(token as! String)"]
    }
}
