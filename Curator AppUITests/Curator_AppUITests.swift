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
        self.appManager.loginHelper.logout()
        
        assert(self.appManager.loginHelper.isLogout())
    }
}
