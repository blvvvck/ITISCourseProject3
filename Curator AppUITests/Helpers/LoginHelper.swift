//
//  LoginBase.swift
//  Curator AppUITests
//
//  Created by Rinat Mukhammetzyanov on 14/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import XCTest

class LoginHelper: HelperBase {

    override init(appManager: AppManager) {
        super.init(appManager: appManager)
    }
    
    func login(with userData: UserData) {
        
        let app = self.appManager.app
        
        app.textFields["Username"].tap()
        let loginTextField = app.textFields["Username"]
        loginTextField.typeText(userData.login)
        
        app.textFields["Password"].tap()
        let passwordTextField = app.textFields["Password"]
        passwordTextField.typeText(userData.password)
        
        app.buttons["LOG IN"].tap()
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Темы"].tap()
        tabBarsQuery.buttons["Курсовые"].tap()
        
    }
    
    func isLogin() -> Bool {
        return self.appManager.app.tabBars.buttons["Темы"].exists
    }
    
    func logout() {
        let app = self.appManager.app
        
        app.tabBars.buttons["Профиль"].tap()
        app.buttons["Выйти"].tap()
        app.textFields["Username"].tap()
    }
    
    func isLogout() -> Bool{
        return self.appManager.app.textFields["Username"].exists
    }
}
