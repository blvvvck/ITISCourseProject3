//
//  SuggestionThemeCommentTableViewCell.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 07/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class SuggestionThemeCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentAuthorAvatarImageView: UIImageView!
    @IBOutlet weak var commentAuthorNameLabel: UILabel!
    @IBOutlet weak var commentAuthorTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
