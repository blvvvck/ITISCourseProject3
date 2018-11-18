//
//  AuthorizationService.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 04/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation
import PromiseKit

protocol AuthorizationService {
    
    // MARK: Instance Methods
    
    func authorizate(with login: String, and password: String) -> Promise<Bool>
}
