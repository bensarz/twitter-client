//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Log
import UIKit

class TweetsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var tweets = [Tweet]()
    var user: User?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    // MARK: - Actions
    
    @IBAction func composeButtonTapped(sender: UIBarButtonItem) {
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        let alertController = UIAlertController(title: "Not Available.", message: "This functionality will be available shortly.", preferredStyle: .Alert)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}

extension TweetsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = NSStringFromClass(TweetTableViewCell.self)
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? TweetTableViewCell ?? TweetTableViewCell()
        cell.tweet = tweets[indexPath.row]
        cell.usernameLabel.text = user?.username
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
}

extension TweetsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let maxWidth = CGRectGetWidth(tableView.bounds)
        let tweet = tweets[indexPath.row]
        let body = tweet.body as NSString
        let size = CGSize(width: maxWidth, height: CGFloat.max)
        let font = UIFont.systemFontOfSize(17.0)
        let box = body.boundingRectWithSize(size,
            options: [.TruncatesLastVisibleLine, .UsesLineFragmentOrigin],
            attributes: [NSFontAttributeName: font],
            context: nil).size
        let height = 132 - 48 + box.height
        Log.trace(height)
        return height
    }
    
}