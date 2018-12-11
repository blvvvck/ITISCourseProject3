//
//  ThemeModel.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 11/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct ThemeModel: Codable {
    var id: Int
    var title: String?
    var description: String?
    var date_creation: String?
    var date_acceptance: String?
    //var curator: Profile?
    var curator: Int
    //var student: Profile?
    var student: Int
    //var subject: SubjectModel?
    var subject: Int
    var skills: [Int]
    //var skills: [Skill]?

}

struct SubjectModel: Codable {
    var id: Int
    var name: String?
}
