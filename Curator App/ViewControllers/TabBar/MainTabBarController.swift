//
//  MainTabBarController.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 14/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    enum TabBarItemType: Int {
        case profile = 0
        case students = 1
        case courseWorks = 2
        case themes = 3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers()
    }
    
    private func initViewControllers() {
       
        
//        let studentsStoryboard = UIStoryboard(name: "Students", bundle: nil)
//        let studentsVC = studentsStoryboard.instantiateViewController(withIdentifier: "StudentsVC")
//        studentsVC.title = "Студенты"
//        let studentsTabBarItem = UITabBarItem(title: "Студенты", image: nil, selectedImage: nil)
//        studentsTabBarItem.tag = 1
//        studentsVC.tabBarItem = studentsTabBarItem;
        
        let courseStoryboard = UIStoryboard(name: "CourseWork", bundle: nil)
        let courseWorkVC = courseStoryboard.instantiateViewController(withIdentifier: "CourseWorksVC")
        courseWorkVC.title = "Курсовые"
        let courseWorkTabBarItem = UITabBarItem(title: "Курсовые", image: UIImage(named: "language-2"), selectedImage: nil)
        courseWorkTabBarItem.tag = 2
        courseWorkVC.tabBarItem = courseWorkTabBarItem;
        
        let themesStoryboard = UIStoryboard(name: "Themes", bundle: nil)
        let themesVC = themesStoryboard.instantiateViewController(withIdentifier: "ThemesVC")
        themesVC.title = "Темы"
        let themesTabBarItem = UITabBarItem(title: "Темы", image: UIImage(named: "layout"), selectedImage: nil)
        themesTabBarItem.tag = 3
        themesVC.tabBarItem = themesTabBarItem;
        
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "ProfileVC")
        profileVC.title = "Профиль"
        let profileTabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "avatar-2"), selectedImage: nil)
        profileTabBarItem.tag = 0
        profileVC.tabBarItem = profileTabBarItem;
        
        let viewControllers = [courseWorkVC, themesVC, profileVC]

        self.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0)}

    }
}
