//
//  User.swift
//  lostInVLG
//
//  Created by Ios Dev on 03/08/2018.
//  Copyright © 2018 avchugunov. All rights reserved.
//

import Foundation

class User: NSObject {
    let id: String
    let phone: String
    let firstName: String?
    let lastName: String?
    let email: String?
    
    init(id: String, phone: String, firstName: String?, lastName: String?, email: String?) {
        self.id = id
        self.phone = phone
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    
//    "id": 9,
//    "firstName": null,
//    "lastName": null,
//    "phone": "89996256110",
//    "password": "53b91d059fdf42f9cd120a3cb00328a2706b7976abfb6cd597987aeb43840154",
//    "eMail": null
}
