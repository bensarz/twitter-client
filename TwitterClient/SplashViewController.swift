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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = UserModelService.existingUser()
    }
    
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
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        default:
            break
        }
    }
    
}
