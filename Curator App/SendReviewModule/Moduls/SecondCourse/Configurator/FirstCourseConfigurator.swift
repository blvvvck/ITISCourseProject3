//
//  FirstCourseConfigurator.swift
//  CourseProject
//
//  Created by BLVCK on 13/04/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

class FirstCourseConfigurator {
    
    static let studentCourse = "2"
    
    static func setupModule(with viewController: FirstCourseViewController) {

        viewController.studentCourse = studentCourse
        var tableView = UITableView()
        viewController.tableView = tableView
        
        let presenter = CoursePresenter()
        let interactor = CourseInteractor()
        let dbManager = DbManagerImplementation()
        let parserManager = GoogleTableParserManagerImplementation()
        let dataSource = StudentsDataSource()
        let router = CourseRouter()
        
        viewController.presenter = presenter
        viewController.dataSource = dataSource
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.tableParser = parserManager
        parserManager.dbManager = dbManager
        router.viewController = viewController
    }
}
