//
//  ProfileExtractor.swift
//  Curator App
//
//  Created by Rinat Mukhammetzyanov on 24/10/2018.
//  Copyright © 2018 ITIS Mobile Lab. All rights reserved.
//

import Foundation
import PromiseKit

protocol ProfileExtractor {
    
    // MARK: - Instance Mehtods
    
    func extractProfile(from response: [String: Any]) -> Promise<Profile>
}
