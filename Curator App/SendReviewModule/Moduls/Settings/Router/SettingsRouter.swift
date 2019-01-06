//
//  SettingsRouter.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class SettingsRouter: SettingsRouterInput {
    
    weak var view: SettingsViewController!
    var alertFactory: AlertFactory!
    
    func showAlert(with errorMessage: String) {
        let alert = alertFactory.getAlert(with: errorMessage)
        view.present(alert, animated: true, completion: nil)
    }
}
