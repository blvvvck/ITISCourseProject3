//
//  AuthorizationExtractor.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 04/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation
import PromiseKit

protocol AuthorizationExtractor {
    
    //MARK: - Instance Methods
    
    func extractTokens(from response: [String: Any]) -> Promise<Token>
}
