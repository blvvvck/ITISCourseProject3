//
//  StudentsDataSource.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

class StudentsDataSource: NSObject, StudentsDataSourceInput {
    
    var cellModels = [CellModel]()
    let studentCellIdentifier = "studentCell"
    
    func setCellModels(with models: [CellModel]?) {
        guard let checkedModels = models else { return }
        cellModels = checkedModels
    }
    
    func clearTable() {
        cellModels.removeAll()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: studentCellIdentifier, for: indexPath) as! StudentReviewTableViewCell
        let model = cellModels[indexPath.row]
        cell.prepare(with: model)
    
        return cell
    }
}


