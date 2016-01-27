//
//  TweetModelService.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import Log

class TweetModelService: ModelService {
    
    class func fetchNewTweetsSinceDate(date: NSDate, forUser user: User, completion: ((error: NSError?, tweets: [Tweet]?) -> ())?) {
        TwitterNetworkService.fetchTweetsSinceDate(date, forUser: user) { (error, tweets) -> () in
            do {
                if let tweets = tweets {
                    try PersistenceController.persistOrUpdateObjects(tweets)
                }
                completion?(error: error, tweets: tweets)
            } catch let error as NSError {
                Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
                completion?(error: error, tweets: tweets)
            }
        }
    }
    
    class func tweets() -> [Tweet] {
        do {
            return try PersistenceController.objects(Tweet.self, sortedByProperty: "createdDate", ascending: false) ?? []
        } catch let error as NSError {
            Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            return []
        }
    }
    
}
