//
//  ProgressTableViewCell.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 20/11/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit
import BEMCheckBox

class ProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var stepNameLabel: UILabel!
    @IBOutlet weak var stepDateLabel: UILabel!
    @IBOutlet weak var checkBox: BEMCheckBox!
    
    var onCheckBoxClicked: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func onCheckBoxTouchUpInside(_ sender: Any) {
        self.onCheckBoxClicked?()
//        if checkBox.isSelected == false {
//            //checkBox.setOn(true, animated: true)
//            self.onCheckBoxClicked?(true)
//        } else {
//            //checkBox.setOn(false, animated: true)
//            self.onCheckBoxClicked?(false)
//        }
    }
}
