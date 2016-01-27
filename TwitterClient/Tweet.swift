//
//  Tweet.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import RealmSwift

class Tweet: Object {
    
    // MARK: - Properties
    
    dynamic var body           = ""
    dynamic var createdDate    = NSDate(timeIntervalSince1970: 0)
    dynamic var favouriteCount = 0
    dynamic var id             = 0
    dynamic var retweetCount   = 0
    
    // MARK: - Initialization
    
    convenience init(dictionary: [String: AnyObject]) {
        self.init()
        self.body           = (dictionary[ParsingKey.Body.rawValue] as? String) ?? self.body
        self.createdDate    = (dictionary[ParsingKey.CreatedDate.rawValue] as? String)?.ISO8601DateValue ?? self.createdDate
        self.favouriteCount = (dictionary[ParsingKey.FavouriteCount.rawValue] as? Int) ?? self.favouriteCount
        self.id             = (dictionary[ParsingKey.ID.rawValue] as? Int) ?? self.id
        self.retweetCount   = (dictionary[ParsingKey.RetweetCount.rawValue] as? Int) ?? self.retweetCount
    }
    
}

// MARK: - Utilities

extension Tweet {
    
    private enum ParsingKey: String {
        case Body           = "body"
        case CreatedDate    = "created_date"
        case FavouriteCount = "favourite_count"
        case ID             = "id"
        case RetweetCount   = "retweet_count"
    }
    
}

// MARK: - Realm

extension Tweet {
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}