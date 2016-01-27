//
//  SplashViewController.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Log
import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fetchNewTweets()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        guard let _ = UserModelService.existingUser() else {
            performSegueWithIdentifier(SegueID.PresentLoginOptions.rawValue, sender: nil)
            return
        }
        performSegueWithIdentifier(SegueID.PresentTweets.rawValue, sender: nil)
    }
    
    // MARK: - Segues
    
    private enum SegueID: String {
        case PresentLoginOptions = "SegueIDPresentLoginOptions"
        case PresentTweets = "SegueIDPresentTweets"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier ?? "" {
        case SegueID.PresentLoginOptions.rawValue:
            let loginViewController = segue.destinationViewController as? LoginViewController
            loginViewController?.completion = { (error, user) -> Void in
                self.fetchNewTweets()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        case SegueID.PresentTweets.rawValue:
            let tweetsViewController = segue.destinationViewController as? TweetsViewController
            tweetsViewController?.tweets = TweetModelService.tweets()
            tweetsViewController?.user = UserModelService.existingUser()
        default:
            break
        }
    }
    
    // MARK: - Data
    
    /**
    Fetches all the new tweets since the last tweet.
    If there are no tweets in the database, then we fetch all tweets since 24hrs ago.
    */
    private func fetchNewTweets() {
        if let user = UserModelService.existingUser() {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), { () -> Void in
                // [BS] Jan 27, 2016
                // First, we declare a closure to be used later.
                // This closure simply fetches the new tweets based on a given date.
                let performFetch = { (since: NSDate?) -> Void in
                    if let since = since {
                        TweetModelService.fetchNewTweetsSinceDate(since, forUser: user, completion: { (error, tweets) -> () in
                            Log.trace("Error: \(error), Tweets: \(tweets)")
                        })
                    }
                }
                
                // [BS] Jan 27, 2016
                // We get the last tweet's date, otherwise, we create one with -24hrs
                var since = TweetModelService.tweets().first?.createdDate
                guard since != nil else {
                    since = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: .MatchNextTime)
                    performFetch(since)
                    return
                }
                performFetch(since)
            })
        }
    }
    
}
