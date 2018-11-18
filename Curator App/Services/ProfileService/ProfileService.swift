//
//  ProfileService.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 24/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import PromiseKit

protocol ProfileService {
    
    // MARK: - Instance Methods
    
    func getProfileInfo() -> Promise<Profile>
}
