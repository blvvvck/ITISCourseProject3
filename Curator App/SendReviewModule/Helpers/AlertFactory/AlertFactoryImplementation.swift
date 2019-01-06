//
//  AlertFactoryImplementation.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

class AlertFactoryImplementation: AlertFactory {
    
    func getAlert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}

