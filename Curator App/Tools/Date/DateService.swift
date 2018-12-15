//
//  DateService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 12/12/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation

struct DateService {
    
    static let shared = DateService()

    func correctStringDate(from stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        
        guard let date: Date = dateFormatter.date(from: stringDate) else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            guard let date: Date = dateFormatter.date(from: stringDate) else {
                return stringDate
            }
            
            dateFormatter.dateFormat = "MMM d, yyyy"
            
            let correctDateSting = dateFormatter.string(from: date)
            
            return correctDateSting
        }
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let correctDateSting = dateFormatter.string(from: date)
        
        return correctDateSting
    }
    
    func stringDateToServerFormat(from stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        guard let date: Date = dateFormatter.date(from: stringDate) else {
            return stringDate
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        
        let correctDateSting = dateFormatter.string(from: date)
        
        return correctDateSting
    }
    
    func getNowDateInCorrectFormat() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"

        let date = Date()
        
        let correctStringDate = dateFormatter.string(from: date)
        
        return correctStringDate
    }
}
