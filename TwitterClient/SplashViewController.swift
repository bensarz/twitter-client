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
    
    // MARK: - Properties
    
    var user: User?
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        user = UserModelService.existingUser()
        fetchNewTweets()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        guard let _ = user else {
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
                self.user = user
                self.fetchNewTweets()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        case SegueID.PresentTweets.rawValue:
            let tweetsViewController = segue.destinationViewController as? TweetsViewController
            tweetsViewController?.tweets = TweetModelService.tweets()
            tweetsViewController?.user = user
            
            // [BS] Jan 27, 2016
            // We have to set this variable to nil in order to allow for a propper logout.
            // This is very bad. This mechanism needs to be revisited but for the sake of time...
            user = nil
        default:
            break
        }
    }
    
    // MARK: - Data
    
    private func fetchNewTweets() {
        if let user = user {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), { () -> Void in
                var since = TweetModelService.tweets().first?.createdDate
                since = nil == since ? NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: .MatchNextTime) : since
                if let since = since {
                    TweetModelService.fetchNewTweetsSinceDate(since, forUser: user, completion: { (error, tweets) -> () in
                        Log.trace("Error: \(error), Tweets: \(tweets)")
                    })
                }
            })
        }
    }
    
}
