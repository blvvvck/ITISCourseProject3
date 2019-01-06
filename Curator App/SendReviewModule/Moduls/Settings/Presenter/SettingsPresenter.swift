//
//  SettingsPresenter.swift
//  CourseProject
//
//  Created by BLVCK on 12/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation

class SettingsPresenter: SettingsViewOutput, SettingsInteractorOutput {
    
    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!
    let errorMessage = "Заполните все поля"
    
    func viewIsReady() {
        interactor.loadSettings()
    }
    
    func saveSettings(with mentor: String, and link: String, and sheetName: String, and range: String) {
        
        if (mentor == "" || link == "" || sheetName == "" || range == "" ) {
            router.showAlert(with: errorMessage)
        } else {
            interactor.saveSettings(with: mentor, and: link, and: sheetName, and: range)
        }
    }
    
    func didFinishLoadSettings(with settingsModel: SettingsModel) {
        view.setMentor(with: settingsModel.mentor)
        view.setLink(with: settingsModel.link)
        view.setSheetName(with: settingsModel.sheetName)
        view.setRange(with: settingsModel.range)
    }
    
    func didFinishSaveSetting() {
        view.dismisToStudent()
    }
}
