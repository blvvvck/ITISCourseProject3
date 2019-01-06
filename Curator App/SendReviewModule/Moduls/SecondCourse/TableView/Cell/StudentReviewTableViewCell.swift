//
//  StudentTableViewCell.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class StudentReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    override func prepareForReuse() {
        self.backgroundColor = UIColor.white
    }
    
    func prepare(with model: CellModel) {
        nameLabel.text = model.name
        groupLabel.text = model.group
        themeLabel.text = model.theme
        if model.isCompleted {
            self.backgroundColor = UIColor.green
        }
    }
}
