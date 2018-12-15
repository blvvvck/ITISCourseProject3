//
//  CourseWork.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 12/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct CourseWork: Codable {
    var id: Int
    var date_start: String
    var date_finish: String?
    var theme: ThemeModel
}
