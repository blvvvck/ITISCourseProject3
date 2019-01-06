//
//  CommentModel.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 16/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct CommentModel: Codable {
    var id: Int
    var author_name: String
    var content: String
    var date_creation: String
    var step_id: Int?
    var suggestion_id: Int?
}
