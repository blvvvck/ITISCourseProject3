//
//  StepModel.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 11/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct StepModel: Codable {
    var id: Int
    var title: String
    var description: String
    var date_start: String
    var date_finish: String
    var status: StepStatusModel
    
}

struct StepStatusModel: Codable {
    var id: Int
    var name: String
}
