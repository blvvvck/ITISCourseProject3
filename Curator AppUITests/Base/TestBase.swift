//
//  TestBase.swift
//  Curator AppUITests
//
//  Created by Rinat Mukhammetzyanov on 14/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import XCTest

class TestBase: XCTestCase {
    
    var appManager: AppManager!
    
    override func setUp() {
        XCUIApplication().launch()
        self.appManager = AppManager.getInstance
    }
    
}
