//
//  SettingsInitializer.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class SettingsInitializer: NSObject {
    
    @IBOutlet weak var viewController: SettingsViewController!
    
    override func awakeFromNib() {
        
        let _ = SettingsConfigurator.setupModule(with: viewController)
    }
}
