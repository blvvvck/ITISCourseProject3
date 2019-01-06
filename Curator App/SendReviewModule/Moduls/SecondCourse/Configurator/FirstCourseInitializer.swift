//
//  FirstCourseInitializer.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit

class FirstCourseInitializer: NSObject {

    @IBOutlet weak var viewController: FirstCourseViewController!
    
    override func awakeFromNib() {
        
        let _ = FirstCourseConfigurator.setupModule(with: viewController)
    }
}
