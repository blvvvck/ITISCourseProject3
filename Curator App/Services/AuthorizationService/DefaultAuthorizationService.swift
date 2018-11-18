//
//  DefaultAuthorizationService.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 04/10/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation
import PromiseKit

struct DefaultAuthorizationService: AuthorizationService {
 
    // MARK: - Instance Properties
    
    let apiWebService: APIWebService
    let authorizationExtractor: AuthorizationExtractor
    let accountUserBufferCoder: AccountUserBufferCoder
    
    // MARK: - Instance Methods
    
    func authorizate(with login: String, and password: String) -> Promise<Bool> {
        return Promise(resolver: { seal in
            let requestParams = self.accountUserBufferCoder.encode(login: login, password: password)

            firstly {
                self.apiWebService.jsonObject(with: WebRequest(method: .post, path: "exams/login", params: requestParams, headers: ["Content-Type": "application/json;charset=utf-8"]), queue: DispatchQueue.global(qos: .userInitiated))
                //self.apiWebService.jsonObject(with: WebRequest(method: .post, path: "exams/login", params: ["login": "\(login)", "passwords": "\(password)"]))
                //self.apiWebService.jsonObject(with: WebRequest(method: .post, path: "exams/login", params: requestParams, headers: ["Content-Type": "application/json;charset=utf-8"]))
            }.then { response in
                self.authorizationExtractor.extractTokens(from: response)
            }.done { tokens in
                print("ЗАШЛО В ДАН У СЕРВИСА")
                if (tokens.token != "") {
                    seal.fulfill(true)
                } else {
                    seal.fulfill(false)
                }
            }.catch { error in
                seal.reject(error)
            }
        })
    }
}
