//
//  Config.swift
//  lostInVLG
//
//  Created by Ios Dev on 01/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import Foundation

struct GlobalConfig {
    static let YaApiKey = "0baf68e0-370f-4f28-8aec-7404a9128987"
    static let TokenFieldName = "access_token"
    static let TokenTypeField = "token_type"
    static let BaseUrlString = "http://94.250.253.110:8888/v1"
    static let defaultGrantType = "password"
    static let defaultClientID = "1"
    static let defaultClientSecret = "1V0fd8MgVbGeHZaeCbmFlyBWcIxHUILN"
    
    struct registrationFields {
        let phone = "phone"
        let password = "password"
    }
    
    enum apiRefs: String {
        case login = "/api/oauth/token/"
        case userInfo = "/api/user/info/"
        case signUp = "/api/user/"
        
    }
    static func getUrl(ref: apiRefs) -> String {
        return "\(GlobalConfig.BaseUrlString)\(ref.rawValue)"
    }
}
