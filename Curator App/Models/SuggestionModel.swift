//
//  SuggestionModel.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 15/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct SuggestionModel: Codable {
    var id: Int
    var date_creation: String
    var theme: ThemeModel
    var student: Profile?
    var curator: Profile?
    var status: SuggestionStatus
    var progress: Progress?
}

struct SuggestionStatus: Codable {
    var id: Int
    var name: String
}

struct Progress: Codable {
    var id: Int
    var title: String
    var description: String
    var date_update: String
}
