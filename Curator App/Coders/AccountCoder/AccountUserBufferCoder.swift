//
//  AccountUserBufferCoder.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 05/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation

protocol AccountUserBufferCoder {
    
    // MARK: - Instance Methods
    
    func encode(login: String, password: String) -> [String: Any]
}

// MARK: -

extension AccountUserBufferCoder {
    
    // MARK: - Instance Methods
    
    func encode(login: String, password: String) -> [String: Any] {
        return self.encode(login: login, password: password)
    }
}
