//
//  CourseRouter.swift
//  CourseProject
//
//  Created by BLVCK on 19/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

class CourseRouter: CourseRouterInput {
    
    weak var viewController: UIViewController!
    let detailScreenSegueIdentifier = "showDetailScreen"
    
    func showDetailScreen(with id: Int) {
        viewController.performSegue(withIdentifier: detailScreenSegueIdentifier, sender: id)
    }
}
