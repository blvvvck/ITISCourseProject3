//
//  DefaultAuthorizationExtractor.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 04/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation
import PromiseKit

struct DefaultAuthorizationExtractor: AuthorizationExtractor {
    
    // MARK: - Instance Properties
    
    let tokensCoder: TokensCoder
    
    // MARK: - Instance Methods
        
    func extractTokens(from response: [String : Any]) -> Promise<Token> {
        return Promise { seal in
            let token = Token()
            
            guard self.tokensCoder.decode(token: token, from: response) else {
                seal.reject(WebError.badResponse)
                return
            }
            
            seal.fulfill(token)
        }
    }
}
