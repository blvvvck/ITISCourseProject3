//
//  Profile.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 24/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var id: Int
    var name: String
    var last_name: String
    var patronymic: String
    var description: String
    var skills: [Skill]?
}
