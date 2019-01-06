//
//  ThemeStatusesHelper.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 30/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct ThemeStatusesHelper {
    
    static let shared = ThemeStatusesHelper()
    
    func getCorrectStatus(from backEndStatus: String) -> String {
        switch backEndStatus {
        case "WAITING_CURATOR":
            return "Ожидание ответа куратора"
            
        case "WAITING_STUDENT":
            return "Ожидание ответа студента"
            
        case "IN_PROGRESS_CURATOR":
            return "В процессе куратора"
            
        case "IN_PROGRESS_STUDENT":
            return "В процессе студента"
            
        case "CHANGED_CURATOR":
            return "Изменено куратором"
            
        case "CHANGED_STUDENT":
            return "Изменено студентом"
            
        case "REJECTED_CURATOR":
            return "Отклонено куратором"
            
        case "REJECTED_STUDENT":
            return "Отклонено студентом"
            
        case "ACCEPTED_BOTH":
            return "Принято куратором и студентом"
            
        default:
            return ""
        }
    }
}
