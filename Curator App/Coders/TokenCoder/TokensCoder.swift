//
//  TokensCoder.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 04/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation

protocol TokensCoder {

    //MARK: - Instance Methods
    
    func decode(token: Token, from json: [String: Any]) -> Bool
}
