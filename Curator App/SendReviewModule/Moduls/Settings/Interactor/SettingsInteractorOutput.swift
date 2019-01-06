//
//  SettingsInteractorOutput.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

protocol SettingsInteractorOutput: class {
    
    func didFinishLoadSettings(with settingsModel: SettingsModel)
    func didFinishSaveSetting()
    //func didFinish(completionBlock: @escaping (([SettingsModel]?) -> ()))
}
