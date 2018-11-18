//
//  DefaultAccountUserBufferCoder.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 05/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation

struct DefaultAccountUserBufferCoder: AccountUserBufferCoder {
    
    // MARK: - Nested Types
    
    fileprivate enum JSONKeys {
        
        // MARK: - Type Properties
        
        static let login = "login"
        static let password = "password"
    }
    
    // MARK: - Instance Methods
    
    func encode(login: String, password: String) -> [String : Any] {
        var json: [String: Any] = [:]
        
        json[JSONKeys.login] = login
        json[JSONKeys.password] = password
        
        return json
    }
}
