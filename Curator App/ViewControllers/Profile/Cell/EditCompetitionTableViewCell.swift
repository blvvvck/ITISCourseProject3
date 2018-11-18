//
//  EditCompetitionTableViewCell.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 31/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class EditCompetitionTableViewCell: UITableViewCell {

    // MARK: - Instance Properties
    
    @IBOutlet weak var competitionNameLabel: UILabel!
    @IBOutlet weak var lowLevelButton: UIButton!
    @IBOutlet weak var middleLevelButton: UIButton!
    @IBOutlet weak var highLevelButton: UIButton!
    

    @IBAction func onLowButtonTouchUpInside(_ sender: Any) {
        self.deselectAllButtons()
        self.lowLevelButton.isSelected = true
    }
    
    @IBAction func onMiddleButtonTouchUpInside(_ sender: Any) {
        self.deselectAllButtons()
        self.middleLevelButton.isSelected = true
    }
    
    @IBAction func onHighButtonTouchUpInside(_ sender: Any) {
        self.deselectAllButtons()
        self.highLevelButton.isSelected = true
    }
    
    fileprivate func deselectAllButtons() {
        self.lowLevelButton.isSelected = false
        self.middleLevelButton.isSelected = false
        self.highLevelButton.isSelected = false
    }
    
    func returnLevelSelectedButton() -> String {
        if self.lowLevelButton.isSelected {
            return self.lowLevelButton.currentTitle!
        } else if self.middleLevelButton.isSelected {
            return self.middleLevelButton.currentTitle!
        } else {
            return self.highLevelButton.currentTitle!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
