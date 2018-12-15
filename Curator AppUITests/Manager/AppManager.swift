//
//  AppManager.swift
//  Curator AppUITests
//
//  Created by Rinat Mukhammetzyanov on 14/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import XCTest

class AppManager {
    
    static let getInstance = AppManager()
    
    var loginHelper: LoginHelper!
    var app = XCUIApplication()
    
    private init() {
        self.loginHelper = LoginHelper(appManager: self)
    }
}
