//
//  TwitterNetworkService.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import Log

class TwitterNetworkService {
    
    /**
     Authenticates a user based on the combination of their username and password against the Twitter API.
     
     - parameter user:       The user to authenticate.
     - parameter completion: The completion closure called once the operation completes.
     */
    class func authenticateUser(user: User, completion: ((error: NSError?, user: User?) -> ())?) {
        // [BS] Jan 26, 2016
        // We're going to fake the authentication here.
        // The username must be: @kyloren
        // The password must be: UseTheForce
        if user.username != "@kyloren" || user.password != "UseTheForce" {
            let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Invalid Credentials.", comment: "")]
            let error = NSError(domain: NSStringFromClass(TwitterNetworkService.self), code: 1, userInfo: userInfo)
            completion?(error: error, user: nil)
        } else {
            // [BS] Jan 26, 2016
            // Also, since we're not actually making a network request, we're going to use the following
            // string as a network response.
            let responseString = "{\"username\":\"@kyloren\",\"first_name\":\"Kylo\",\"last_name\":\"Ren\",\"email\":\"kylo.ren@darkside.force\",\"id\":568}"
            do {
                if
                    let data = responseString.dataUsingEncoding(NSUTF8StringEncoding),
                    let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject] {
                        let u = User(dictionary: JSON)
                        completion?(error: nil, user: u)
                } else {
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("The network request failed.", comment: "")]
                    let error = NSError(domain: NSStringFromClass(TwitterNetworkService.self), code: 1, userInfo: userInfo)
                    completion?(error: error, user: nil)
                }
            } catch let error as NSError {
                Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
                completion?(error: error, user: nil)
            }
        }
    }
    
    /**
     Fetches new tweets since a given date for a given user.
     
     - parameter date:       The date to use as baseline.
     - parameter user:       The user that tweeted the tweets.
     - parameter completion: The completion closure that is called when the operation completes.
     */
    class func fetchTweetsSinceDate(date: NSDate, forUser user: User, completion: ((error: NSError?, tweets: [Tweet]?) -> ())?) {
        completion?(error: nil, tweets: TweetProducer.tweetsSinceDate(date))
    }
    
    /**
     Posts a new tweet for a given user.
     
     - parameter tweet:      The tweet to post.
     - parameter user:       The user tweeting the tweet.
     - parameter completion: The completion closure that is called when the operation completes.
     */
    class func postTweet(tweet: Tweet, forUser user: User, completion: ((error: NSError?, tweet: Tweet?) -> ())?) {
        // [BS] Jan 27, 2016
        // We would normally hit the Twitter API at this point but we're simply going to fake it.
        // This is obviously not proper, but in order to keep a consistent timeline, we're simply
        // going to use the latest tweet we have in our database to set the created date of this future tweet.
        let latest = TweetModelService.tweets().first
        if let next = NSCalendar.currentCalendar().dateByAddingUnit(.Minute, value: 10, toDate: latest?.createdDate ?? NSDate(), options: .MatchNextTime) {
            tweet.createdDate = next
            tweet.id = Int(next.timeIntervalSince1970)
            completion?(error: nil, tweet: tweet)
        } else {
            let userInfo = [NSLocalizedDescriptionKey: "Well, what can we say. Twitter is down at the moment."]
            let error = NSError(domain: NSStringFromClass(TwitterNetworkService.self), code: 1, userInfo: userInfo)
            completion?(error: error, tweet: nil)
        }
    }
    
}
