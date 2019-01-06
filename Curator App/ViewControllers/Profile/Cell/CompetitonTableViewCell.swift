//
//  CompetitonTableViewCell.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 31/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class CompetitonTableViewCell: UITableViewCell {

    // MARK: - Instance Properties
    
    @IBOutlet weak var competitionNameLabel: UILabel!
    @IBOutlet weak var competitionLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
