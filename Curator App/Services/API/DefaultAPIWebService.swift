//
//  DefaultAPIWebService.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 13/09/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation
import PromiseKit

struct DefaultAPIWebService: APIWebService {
    
    // MARK: - Instance Properties
    
    let webService: WebService
    
    // MARK: - Instance Methods
    
    fileprivate func jsonResponse<Response>(with webHandler: WebHandler, queue: DispatchQueue?) -> Promise<Response> {
        return Promise(resolver: { seal in
            webHandler.responseJSON(queue: queue, completion: { response, error in
                webHandler.keepAlive()
                
                if let response = response as? Response {
                    seal.fulfill(response)
                } else {
                    seal.reject(WebError.badResponse)
                }
            })
        })
    }
    
    fileprivate func jsonResponse<Response>(with webRequest: WebRequest, queue: DispatchQueue?) -> Promise<Response> {
        return self.jsonResponse(with: self.webService.make(request: webRequest), queue: queue)
    }
    
    fileprivate func jsonResponse<Response>(uploadingMultiPart: WebMultiPart, to path: String, queue: DispatchQueue?) -> Promise<Response> {
        return Promise(resolver: { seal in
            self.webService.upload(multiPart: uploadingMultiPart, to: path, encodingCompletion: { webHandler, error in
                if let webHandler = webHandler {
                    firstly {
                        self.jsonResponse(with: webHandler, queue: queue)
                        }.done { response in
                            seal.fulfill(response)
                        }.catch { error in
                            seal.reject(error)
                    }
                } else {
                    seal.reject(error ?? WebError.badRequest)
                }
            })
        })
    }
    
    // MARK: - APIWebService
    
    func jsonArray(with webRequest: WebRequest, queue: DispatchQueue? = nil) -> Promise<[[String: Any]]> {
        return self.jsonResponse(with: webRequest, queue: queue)
    }
    
    func jsonObject(with webRequest: WebRequest, queue: DispatchQueue? = nil) -> Promise<[String: Any]> {
        return self.jsonResponse(with: webRequest, queue: queue)
    }
    
    func json(with webRequest: WebRequest, queue: DispatchQueue? = nil) -> Promise<Any?> {
        return self.jsonResponse(with: webRequest, queue: queue)
    }
    
    func jsonArray(uploadingMultiPart: WebMultiPart, to path: String, queue: DispatchQueue? = nil) -> Promise<[[String: Any]]> {
        return self.jsonResponse(uploadingMultiPart: uploadingMultiPart, to: path, queue: queue)
    }
    
    func jsonObject(uploadingMultiPart: WebMultiPart, to path: String, queue: DispatchQueue? = nil) -> Promise<[String: Any]> {
        return self.jsonResponse(uploadingMultiPart: uploadingMultiPart, to: path, queue: queue)
    }
    
    func json(uploadingMultiPart: WebMultiPart, to path: String, queue: DispatchQueue? = nil) -> Promise<Any?> {
        return self.jsonResponse(uploadingMultiPart: uploadingMultiPart, to: path, queue: queue)
    }
}
