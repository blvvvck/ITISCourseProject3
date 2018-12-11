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
    var date_start: Date
    var date_finish: Date
    var status: StepStatusModel
    
}

struct StepStatusModel: Codable {
    var id: Int
    var name: String
}
