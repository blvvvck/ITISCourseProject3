//
//  Services.swift
//  Portal402
//
//  Created by Rinat Mukhammetzyanov on 12/09/2018.
//  Copyright © 2018 KFU ITIS. All rights reserved.
//

import Foundation

enum Services {
    
    // MARK: - Coders
    
    static let tokensCoder: TokensCoder = DefaultTokensCoder()
    
    static let accountUserBufferCoder: AccountUserBufferCoder = DefaultAccountUserBufferCoder()

    // MARK: - Extractors
    
    static let authorizationExtractor: AuthorizationExtractor = DefaultAuthorizationExtractor(tokensCoder: Services.tokensCoder)

    // MARK: - Services
    
    static let webService: WebService = AlamofireWebService(serverBaseURL: Keys.apiServerBaseURL, requestAdapter: nil)
    
    static let apiWebService: APIWebService = DefaultAPIWebService(webService: Services.webService)
    
    //static let groupService: GroupService = DefaultGroupService(apiWebService: Services.apiWebService)
    
    static let authorizationService: AuthorizationService = DefaultAuthorizationService(apiWebService: Services.apiWebService, authorizationExtractor: Services.authorizationExtractor, accountUserBufferCoder: Services.accountUserBufferCoder)
}
