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
    case getSuggestionComments(Int, Int)
    case addSuggestionComment(Int, Int, CommentModel)
    case updateSuggestion(Int, Int, Int)
    case updateSuggestionProgress(Int, Int, String, String)
    case getSuggestionProgress(Int, Int)
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
            return "curators/\(themeModel.curator.id)/suggestions"
        
        case .getThemes(let id):
            return "curators/\(id)/themes"
            
        case .getTheme(let curatorId, let themeId):
            return "curators/\(curatorId)/themes/\(themeId)"
            
        case .addTheme(let themeModel):
            return "curators/\(themeModel.curator.id)/themes"
            
        case .updateTheme(let themeModel):
            return "curators/\(themeModel.curator.id)/themes/\(themeModel.id)"
            
        case .getSuggestionComments(let curatorId, let suggestionId):
            return "curators/\(curatorId)/suggestions/\(suggestionId)/comments"
            
        case .addSuggestionComment(let curatorId, let suggestionId, _):
            return "curators/\(curatorId)/suggestions/\(suggestionId)/comments"
            
        case .updateSuggestion(let curatorId, let suggestionId, _):
            return "curators/\(curatorId)/suggestions/\(suggestionId)"
            
        case .updateSuggestionProgress(let curatorId, let suggestionId, _, _):
            return "curators/\(curatorId)/suggestions/\(suggestionId)/progress"
            
        case .getSuggestionProgress(let curatorId, let suggestionId):
            return "curators/\(curatorId)/suggestions/\(suggestionId)/progress"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSuggestions,
             .getSuggestion,
             .getTheme,
             .getThemes,
             .getSuggestionComments,
             .getSuggestionProgress:
            return .get
            
        case .addTheme, .addSuggestion, .addSuggestionComment:
            return .post
            
        case .updateTheme, .updateSuggestion, .updateSuggestionProgress:
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
             .getTheme,
             .getSuggestionComments,
             .getSuggestionProgress:
            return .requestPlain
            
        case .addSuggestion(let themeModel):
            var parameters = [String: Any]()
            //parameters["date_creation"] = DateService.shared.getNowDateInCorrectFormat()
            parameters["theme_id"] = themeModel.id
            parameters["student_id"] = themeModel.student!.id
            parameters["curator_id"] = themeModel.curator.id
            parameters["status_id"] = 1
            
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .addTheme(let themeModel):
            var parameters = [String: Any]()
            parameters["title"] = themeModel.title
            parameters["description"] = themeModel.description
            //parameters["date_creation"] = DateService.shared.getNowDateInCorrectFormat()
            parameters["subject_id"] = themeModel.subject!.id
            parameters["curator_id"] = themeModel.curator.id
            let skillsIds = themeModel.skills!.map({$0.id})
            parameters["skills_id"] = skillsIds
            
            parameters["student_id"] = 1
            
            
        
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .updateTheme(let themeModel):
            var parameters = [String: Any]()
            parameters["title"] = themeModel.title
            parameters["description"] = themeModel.description
            //parameters["date_creation"] = DateService.shared.getNowDateInCorrectFormat()
            
            
            //parameters["subject"] = themeModel.subject!.id
            
            if let subject = themeModel.subject {
                parameters["subject_id"] = subject.id
            }
            
            let skillsIds = themeModel.skills!.map({$0.id})
            parameters["skills_id"] = skillsIds
            
            if let student = themeModel.student {
                parameters["student_id"] = student.id
            }
            
            parameters["curator_id"] = themeModel.curator.id
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .addSuggestionComment(_, _, let commentModel):
            var parameters = [String: Any]()
            
            parameters["author_name"] = commentModel.author_name
            parameters["content"] = commentModel.content
            //parameters["date_creation"] = commentModel.date_creation
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .updateSuggestion(_, _, let statusId):
            var parameters = [String: Any]()
            
            parameters["status_id"] = statusId
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .updateSuggestionProgress(_, _, let title , let description):
            var parameters = [String: Any]()
            
            parameters["title"] = title
            parameters["description"] = description
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        }
        
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.value(forKey: "token")
        return ["Authorization":"Token \(token as! String)"]
    }
}
