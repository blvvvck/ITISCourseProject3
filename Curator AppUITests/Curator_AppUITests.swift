//
//  Curator_AppUITests.swift
//  Curator AppUITests
//
//  Created by Rinat Mukhammetzyanov on 14/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import XCTest

class Curator_AppUITests: TestBase {


    func testExample() {
        
//        let userData = UserData(login: "login", password: "123")
//
//        self.appManager.loginHelper.login(with: userData)
//
//        assert(self.appManager.loginHelper.isLogin())
        
        self.appManager.loginHelper.logout()
        
        assert(self.appManager.loginHelper.isLogout())
    }
}
