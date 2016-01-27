//
//  TweetTableViewCell.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favouriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    // MARK: - Properties
    
    var tweet: Tweet? {
        didSet {
            bodyLabel?.text = tweet?.body
            dateLabel?.text = tweet?.createdDate.defaultStringValue
            favouriteLabel?.text = "\(tweet?.favouriteCount ?? 0)"
            retweetLabel?.text = "\(tweet?.retweetCount ?? 0)"
        }
    }
    
    // MARK: - Selection
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
