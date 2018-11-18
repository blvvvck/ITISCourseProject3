//
//  APIWebService.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 12/09/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation
import PromiseKit

protocol APIWebService {
    
    // MARK: - Instance Methods
    
    func jsonArray(with webRequest: WebRequest, queue: DispatchQueue?) -> Promise<[[String: Any]]>
    func jsonObject(with webRequest: WebRequest, queue: DispatchQueue?) -> Promise<[String: Any]>
    func json(with webRequest: WebRequest, queue: DispatchQueue?) -> Promise<Any?>
    
    func jsonArray(uploadingMultiPart: WebMultiPart, to path: String, queue: DispatchQueue?) -> Promise<[[String: Any]]>
    func jsonObject(uploadingMultiPart: WebMultiPart, to path: String, queue: DispatchQueue?) -> Promise<[String: Any]>
    func json(uploadingMultiPart: WebMultiPart, to path: String, queue: DispatchQueue?) -> Promise<Any?>
}

// MARK: -

extension APIWebService {
    
    // MARK: - Instance Methods
    
    func jsonArray(with webRequest: WebRequest) -> Promise<[[String: Any]]> {
        return self.jsonArray(with: webRequest, queue: nil)
    }
    
    func jsonObject(with webRequest: WebRequest) -> Promise<[String: Any]> {
        return self.jsonObject(with: webRequest, queue: nil)
    }
    
    func json(with webRequest: WebRequest) -> Promise<Any?> {
        return self.json(with: webRequest, queue: nil)
    }
    
    func jsonArray(uploadingMultiPart: WebMultiPart, to path: String) -> Promise<[[String: Any]]> {
        return self.jsonArray(uploadingMultiPart: uploadingMultiPart, to: path, queue: nil)
    }
    
    func jsonObject(uploadingMultiPart: WebMultiPart, to path: String) -> Promise<[String: Any]> {
        return self.jsonObject(uploadingMultiPart: uploadingMultiPart, to: path, queue: nil)
    }
    
    func json(uploadingMultiPart: WebMultiPart, to path: String) -> Promise<Any?> {
        return self.json(uploadingMultiPart: uploadingMultiPart, to: path, queue: nil)
    }
}
