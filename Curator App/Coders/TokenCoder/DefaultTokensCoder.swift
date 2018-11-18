//
//  DefaultTokensCoder.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 04/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation
import Gloss

struct DefaultTokensCoder: TokensCoder {
    
    //MARK: - Nested Types
    
    fileprivate enum JSONKeys {
        static let token = "Token"
    }
    
    //MARK: - Instance Methods
    
    func decode(token: Token, from json: [String : Any]) -> Bool {
        guard let rawToken: String = JSONKeys.token <~~ json else {
            return false
        }
        
        token.token = rawToken

        return true
    }
}
