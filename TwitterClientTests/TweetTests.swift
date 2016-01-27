//
//  TweetTests.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import XCTest
@testable import TwitterClient

class TweetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultValues() {
        let now = NSDate(timeIntervalSince1970: 0)
        let tweet = Tweet()
        XCTAssertEqual(tweet.body, "", "The tweet has the wrong default email.")
        XCTAssertEqual(tweet.favouriteCount, 0, "The tweet has the wrong default favourite count.")
        XCTAssertEqual(tweet.id, 0, "The tweet has the wrong default id.")
        XCTAssertEqual(tweet.retweetCount, 0, "The tweet has the wrong default retweet count.")
        
        // [BS] Jan 27, 2016
        // This is a tiny bit tricky.
        // We're going to assume that for some exceptional reason, the two date values
        // might be created in a particular way that would allow for this value to not
        // be identical. We're going to tolerate a 1 millisecond difference.
        // We can adjust the test if this continually fails.
        let delta = abs(now.timeIntervalSince1970 - tweet.createdDate.timeIntervalSince1970)
        XCTAssert(delta < 1, "The tweet has the wrong default created date.")
    }
    
    func testInitDictionary() {
        let dictionary = [
            "body": "Hello World!",
            "created_date": "1970-01-01T00:00:00 +0000",
            "favourite_count": 12345,
            "id": 999,
            "retweet_count": 56789,
        ]
        
        let tweet = Tweet(dictionary: dictionary)
        XCTAssertEqual(tweet.body, "Hello World!", "The body does not match.")
        XCTAssertEqual(tweet.body, dictionary["body"], "The body does not match.")
        XCTAssertEqual(tweet.favouriteCount, 12345, "The favourite count does not match.")
        XCTAssertEqual(tweet.favouriteCount, dictionary["favourite_count"], "The favourite count does not match.")
        XCTAssertEqual(tweet.id, 999, "The id does not match.")
        XCTAssertEqual(tweet.id, dictionary["id"], "The id does not match.")
        XCTAssertEqual(tweet.retweetCount, 56789, "The retweet count does not match.")
        XCTAssertEqual(tweet.retweetCount, dictionary["retweet_count"], "The retweet count does not match.")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.dateFromString((dictionary["created_date"] as? String) ?? "") {
            XCTAssertEqual(tweet.createdDate, date, "The date does not match.")
        } else {
            XCTFail("Unable to convert the string into a valid date.")
        }
        
        if let date = formatter.dateFromString("1970-01-01T00:00:00 +0000") {
            XCTAssertEqual(tweet.createdDate, date, "The date does not match.")
        } else {
            XCTFail("Unable to convert the string into a valid date.")
        }
    }
    
    func testParsingKeys() {
        XCTAssertEqual(Tweet.ParsingKey.Body.rawValue, "body", "The parsing key 'body' is invalid.")
        XCTAssertEqual(Tweet.ParsingKey.CreatedDate.rawValue, "created_date", "The parsing key 'created_date' is invalid.")
        XCTAssertEqual(Tweet.ParsingKey.FavouriteCount.rawValue, "favourite_count", "The parsing key 'favourite_count' is invalid.")
        XCTAssertEqual(Tweet.ParsingKey.ID.rawValue, "id", "The parsing key 'id' is invalid.")
        XCTAssertEqual(Tweet.ParsingKey.RetweetCount.rawValue, "retweet_count", "The parsing key 'retweet_count' is invalid.")
    }
    
    func testRealm() {
        XCTAssertEqual(Tweet.primaryKey(), "id", "The primary key is invalid.")
    }
    
}
