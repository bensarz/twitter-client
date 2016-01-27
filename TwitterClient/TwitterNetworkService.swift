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
    
    class func fetchTweetsSinceDate(date: NSDate, forUser user: User, completion: ((error: NSError?, tweets: [Tweet]?) -> ())?) {
        completion?(error: nil, tweets: TweetProducer.tweetsSinceDate(date))
    }
    
}
