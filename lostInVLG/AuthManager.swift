//
//  AuthManager.swift
//  lostInVLG
//
//  Created by Ios Dev on 03/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class AuthManager {
    var loggedIn = false
    private var accessToken = ""
    private var tokenType = ""
    var currentUser: User? = nil
    
    func initializeAuthentification () {
        let storedToken = UserDefaults.standard.string(forKey: GlobalConfig.TokenFieldName)
        let storedTokenType = UserDefaults.standard.string(forKey: GlobalConfig.TokenTypeField)
        if let token = storedToken, token != "", let tokenType = storedTokenType, tokenType != "" {
            getUserInfo(token: token, tokenType: tokenType) { (user, error) in
                if error == nil, let curUser = user {
                    self.currentUser = curUser
                    self.accessToken = token
                    self.tokenType = tokenType
                    self.loggedIn = true
                } else {
                    self.clearAccessFields()
                }
            }
        } else {
            clearAccessFields()
        }
    }
    
    //current user info
    func getUserInfo (token: String, tokenType: String, completion: @escaping (User?, Error?) -> Void) {
        print("token: \(token)")
        let url = GlobalConfig.getUrl(ref: .userInfo)
        //let headers: HTTPHeaders = ["Authorization": self.getAuthHeader(), "Accept": "application/json"]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)", "Accept": "application/json"]
        let request = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
        request.validate()
        request.response { (response) in
            if response.error == nil {
                if let data = response.data {
                    let userJSON = JSON(data)
                    print("\(userJSON)")
                    let id = userJSON["id"].stringValue
                    let phone = userJSON["phone"].stringValue
                    let fn = userJSON["firstName"] == JSON.null ? nil : userJSON["firstName"].stringValue
                    let ln = userJSON["lastName"] == JSON.null ? nil : userJSON["lastName"].stringValue
                    let em = userJSON["eMail"] == JSON.null ? nil : userJSON["eMail"].stringValue
                    
                    let user = User(id: id, phone: phone, firstName: fn, lastName: ln, email: em)
                    completion(user, nil)
                }
            } else {
                let responseMessage = String(data: response.data!, encoding: String.Encoding.utf8)!
                print("\(response.error!.localizedDescription) \n\(responseMessage)")
                if responseMessage == "Unauthorized" {
                    completion(nil, response.error)
                }
            }
        }
    }
    
    //login
    func requestAuthentification (phone: String, password: String, completion: @escaping (String?) -> Void) {
        let url = GlobalConfig.getUrl(ref: .login)
        let params: [String: String] = ["grant_type": GlobalConfig.defaultGrantType, "client_id": GlobalConfig.defaultClientID, "client_secret": GlobalConfig.defaultClientSecret,
                                        "username": phone, "password": password]
        let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
        request.validate()
        request.response { (response) in
            if response.error == nil {
                if let data = response.data {
                    let token = JSON(data)[GlobalConfig.TokenFieldName].stringValue
                    let tokenType = JSON(data)[GlobalConfig.TokenTypeField].stringValue
                    print("token: \(token)")
                    UserDefaults.standard.set(token, forKey: GlobalConfig.TokenFieldName)
                    UserDefaults.standard.set(tokenType, forKey: GlobalConfig.TokenTypeField)
                    self.accessToken = token
                    self.tokenType = tokenType
                    self.loggedIn = true
                    completion(token)
                } else {
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
    }
    
    //sign up
    func requestRegistration (phone: String, password: String, completion: @escaping (Bool) -> Void) {
        let url = GlobalConfig.getUrl(ref: .signUp)
        let params: [String:String] = ["phone": phone, "password": password]
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
        request.validate()
        request.response { (response) in
            if response.error == nil {
                if let data = response.data {
                    let returnedPhone = JSON(data)["phone"].stringValue
                    completion(phone == returnedPhone)
                } else {
                    completion(false)
                }
            } else {
                print("response: \(String(data: response.data!, encoding: String.Encoding.utf8)!)")
                completion(false)
            }
        }
    }
    
    private func getAuthHeader () -> String {
        return "\(tokenType) \(accessToken)"
    }
    
    private func clearAccessFields () {
        loggedIn = false
        accessToken = ""
        tokenType = ""
    }
}
