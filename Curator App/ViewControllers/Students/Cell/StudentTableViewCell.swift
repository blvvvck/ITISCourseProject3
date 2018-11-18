//
//  StudentTableViewCell.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 30/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var studentAvatarImageView: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentSurnameLabel: UILabel!
    @IBOutlet weak var studentLastNameLabel: UILabel!
    @IBOutlet weak var studentGroupLabel: UILabel!
    @IBOutlet weak var studentCourseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
