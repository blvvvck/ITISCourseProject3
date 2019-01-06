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
    case updateWorkStep(Int, Int, StepModel)
    case getWorkStep(Int, Int, Int)
    case addWorkStep(Int, Int, StepModel)
    case getStepComments(Int, Int, Int)
    case getStepMaterials(Int, Int, Int)
    case addStepMaterial(Int, Int, Int, MaterialModel)
    case addStepComment(Int, Int, CommentModel)
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
            
        case .updateWorkStep(let curatorId, let workId, let stepModel):
            return "curators/\(curatorId)/works/\(workId)/steps/\(stepModel.id)"
            
        case .getWorkStep(let curatorId, let workId, let stepId):
            return "curators/\(curatorId)/works/\(workId)/steps/\(stepId)"
            
        case .addWorkStep(let curatorId, let workId, _):
            return "curators/\(curatorId)/works/\(workId)/steps"
            
        case .getStepComments(let curatorId, let workId, let stepId):
            return "curators/\(curatorId)/works/\(workId)/steps/\(stepId)/comments"
            
        case .getStepMaterials(let curatorId, let workId, let stepId):
            return "curators/\(curatorId)/works/\(workId)/steps/\(stepId)/materials"
            
        case .addStepMaterial(let curatorId, let workId, let stepId, _):
            return "curators/\(curatorId)/works/\(workId)/steps/\(stepId)/materials"
            
        case .addStepComment(let curatorId, let workId, let comment):
            return "curators/\(curatorId)/works/\(workId)/steps/\(comment.step_id!)/comments"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseWorks,.getWorkSteps,.getWorkStep, .getStepComments, .getStepMaterials:
            return .get
            
        case .updateWorkStep:
            return .put
            
        case .addWorkStep, .addStepMaterial, .addStepComment:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCourseWorks, .getWorkSteps, .getWorkStep, .getStepComments, .getStepMaterials:
            return .requestPlain
            
        case .updateWorkStep(let curatorId, let workId, let stepModel):
            var parameters = [String: Any]()
            parameters["title"] = stepModel.title
            parameters["description"] = stepModel.description
            parameters["date_start"] = DateService.shared.stringDateToServerFormat(from: stepModel.date_start)
            parameters["date_finish"] = DateService.shared.stringDateToServerFormat(from: stepModel.date_finish)
            parameters["status_id"] = stepModel.status.id

            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .addWorkStep(_, _, let stepModel):
            var parameters = [String: Any]()
            parameters["title"] = stepModel.title
            parameters["description"] = stepModel.description
            parameters["date_start"] = DateService.shared.stringDateToServerFormat(from: stepModel.date_start)
            parameters["date_finish"] = DateService.shared.stringDateToServerFormat(from: stepModel.date_finish)
            parameters["status_id"] = stepModel.status.id
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .addStepMaterial(_, _, _, let materialModel):
            var parameters = [String: Any]()
            
            parameters["content"] = materialModel.content
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .addStepComment(_, _, let commentModel):
            var parameters = [String: Any]()
            
            parameters["author_name"] = commentModel.author_name
            parameters["content"] = commentModel.content
            //parameters["date_creation"] = commentModel.date_creation
            
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let token = UserDefaults.standard.value(forKey: "token")
        return ["Authorization":"Token \(token as! String)"]
    }
}
