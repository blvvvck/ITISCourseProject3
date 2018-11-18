//
//  Profile.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 24/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let id: Int
    let name: String
    let surnemt: String
    let patronymic: String
    let description: String
}
