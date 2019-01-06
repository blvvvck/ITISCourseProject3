//
//  StudentsDataSourceInput.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

protocol StudentsDataSourceInput: UITableViewDelegate, UITableViewDataSource {
    
    func setCellModels(with models: [CellModel]?)
    func clearTable()
}
