//
//  SettingsRouterInput.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol SettingsRouterInput {
    
    /// Отобразить алерт
    ///
    /// - Parameter alert: сообщение для отображения в алерте
    func showAlert(with errorMessage: String)
}
