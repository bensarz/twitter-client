//
//  User.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    // MARK: - Properties
    
    dynamic var email              = ""
    dynamic var firstName          = ""
    dynamic var id                 = 0
    dynamic var lastName           = ""
    dynamic var password           = ""
    dynamic var username           = ""
    
    // MARK: - Initialization
    
    convenience init(password: String, username: String) {
        self.init()
        self.email = email ?? self.email
        self.password = password ?? self.password
        self.username = username ?? self.username
    }
    
    convenience init(dictionary: [String: AnyObject]) {
        self.init()
        self.email     = (dictionary[ParsingKey.Email.rawValue] as? String) ?? self.email
        self.firstName = (dictionary[ParsingKey.FirstName.rawValue] as? String) ?? self.firstName
        self.id        = (dictionary[ParsingKey.ID.rawValue] as? Int) ?? self.id
        self.lastName  = (dictionary[ParsingKey.LastName.rawValue] as? String) ?? self.lastName
        self.username  = (dictionary[ParsingKey.Username.rawValue] as? String) ?? self.username
    }
    
}

// MARK: - Utilities

extension User {
    
    private enum ParsingKey: String {
        case Email     = "email"
        case FirstName = "first_name"
        case ID        = "id"
        case LastName  = "last_name"
        case Username  = "username"
    }
    
}

// MARK: - Realm

extension User {
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["password"]
    }
    
}
