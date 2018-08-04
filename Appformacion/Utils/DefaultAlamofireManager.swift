//
//  DefaultAlamofireManager.swift
//  Appformacion
//
//  Created by QUBICGO SAC on 22/04/18.
//  Copyright © 2018 Qubicgo SAC. All rights reserved.
//

import Foundation
import Alamofire

class DefaultAlamofireManager: Alamofire.SessionManager {
    
    static let sharedInstance: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 200 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 200 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.httpShouldUsePipelining = true
        
        return DefaultAlamofireManager(configuration: configuration, serverTrustPolicyManager: CustomServerTrustPoliceManager())
    }()
    
    class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
        override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
            return .disableEvaluation
        }
        public init() {
            super.init(policies: [:])
        }
    }
    
}
