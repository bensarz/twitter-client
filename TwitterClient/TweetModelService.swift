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
    
    /**
     Fetches new tweets against the Twitter API since a given date for a given user.
     
     - parameter date:       The date to use as baseline.
     - parameter user:       The user that tweeted the tweets.
     - parameter completion: The completion closure that is called when the operation completes.
     */
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
    
    /**
     Posts a new tweet to the Twitter API for a given user.
     
     - parameter tweet:      The tweet to tweet.
     - parameter user:       The user tweeting the new tweet.
     - parameter completion: The completion closure that is called when the operation completes.
     */
    class func postNewTweet(tweet: Tweet, forUser user: User, completion: ((error: NSError?, tweet: Tweet?) -> ())?) {
        TwitterNetworkService.postTweet(tweet, forUser: user, completion: { (error, tweet) -> () in
            do {
                if let tweet = tweet {
                    try PersistenceController.persistOrUpdateObjects([tweet])
                    completion?(error: error, tweet: tweet)
                }
            } catch let error as NSError {
                Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
                completion?(error: error, tweet: tweet)
            }
        })
    }
    
    /**
     Fetch the local tweets in the database ordered by their created date in descending order.
     
     - returns: An array of tweets.
     */
    class func tweets() -> [Tweet] {
        do {
            return try PersistenceController.objects(Tweet.self, sortedByProperty: "createdDate", ascending: false) ?? []
        } catch let error as NSError {
            Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            return []
        }
    }
    
}
