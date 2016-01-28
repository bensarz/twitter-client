//
//  PersistenceControllerTests.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import RealmSwift
import XCTest
@testable import TwitterClient

class PersistenceControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        PersistenceController.builder = {
            do {
                let config = Realm.Configuration(inMemoryIdentifier: NSStringFromClass(PersistenceControllerTests.self))
                return try Realm(configuration: config)
            } catch let error as NSError {
                XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
                return nil
            }
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuilder() {
        let realm = PersistenceController.builder
        XCTAssert(realm != nil, "The Realm must not be nil.")
    }
    
    func testPersistTweet() {
        let tweet = Tweet()
        tweet.id = 123
        do {
            try PersistenceController.persistOrUpdateObjects([tweet])
            if let persistedTweet = self.realm()?.objects(Tweet.self).first {
                XCTAssertEqual(tweet.id, persistedTweet.id, "The id of both tweets must match.")
            } else {
                XCTFail("A tweet was not persisted.")
            }
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    func testPersistUser() {
        let user = User(password: "password", username: "username")
        user.id = 678
        do {
            try PersistenceController.persistOrUpdateObjects([user])
            if let persistedUser = self.realm()?.objects(User.self).first {
                XCTAssertEqual(user.id, persistedUser.id, "The id of both users must match.")
            } else {
                XCTFail("A user was not persisted.")
            }
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    func testPersistObjectsOfDifferentTypes() {
        let entities = self.entities()
        let tweet = entities.tweet
        let user = entities.user
        
        do {
            try PersistenceController.persistOrUpdateObjects([tweet, user])
            if let persistedTweet = self.realm()?.objects(Tweet.self).first {
                XCTAssertEqual(tweet.id, persistedTweet.id, "The id of both tweets must match.")
            } else {
                XCTFail("The tweet was not persisted.")
            }
            if let persistedUser = self.realm()?.objects(User.self).first {
                XCTAssertEqual(user.id, persistedUser.id, "The id of both users must match.")
            } else {
                XCTFail("The user was not persisted.")
            }
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    func testDeleteAllObjects() {
        let entities = self.entities()
        let tweet = entities.tweet
        let user = entities.user
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add(tweet, update: true)
                self.realm()?.add(user, update: true)
            })
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
        
        PersistenceController.deleteAllObjects()
        
        let tweets = self.realm()?.objects(Tweet.self)
        XCTAssert(tweets?.count == 0, "The tweets must be deleted.")
        let users = self.realm()?.objects(User.self)
        XCTAssert(users?.count == 0, "The users must be deleted.")
    }
    
    func testFetchObject() {
        let entities = self.entities()
        let tweet = entities.tweet
        let user = entities.user
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add(tweet, update: true)
                self.realm()?.add(user, update: true)
            })
            
            let persistedTweet = try PersistenceController.object(Tweet.self)
            XCTAssertEqual(tweet.id, persistedTweet?.id, "The tweet IDs must match.")
            let persistedUser = try PersistenceController.object(User.self)
            XCTAssertEqual(user.id, persistedUser?.id, "The user IDs must match.")
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    func testFetchObjectWithPredicate() {
        let tweets = self.tweets()
        let tweet1 = tweets[0]
        let tweet2 = tweets[1]
        let tweet3 = tweets[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([tweet1, tweet2, tweet3], update: true)
            })
            
            let predicateWithID = NSPredicate(format: "id == %d", 456)
            let persistedTweetWithID = try PersistenceController.object(Tweet.self, withPredicate: predicateWithID)
            XCTAssertEqual(tweet2.id, persistedTweetWithID?.id, "The tweet that was fetched is not the expected tweet.")
            
            let predicateWithBody = NSPredicate(format: "body == %@", "Hola Mundo!")
            let persistedTweetWithBody = try PersistenceController.object(Tweet.self, withPredicate: predicateWithBody)
            XCTAssertEqual(tweet3.id, persistedTweetWithBody?.id, "The tweet that was fetched is not the expected tweet.")
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
        
        let users = self.users()
        let user1 = users[0]
        let user2 = users[1]
        let user3 = users[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([user1, user2, user3], update: true)
            })
            
            let predicateWithID = NSPredicate(format: "id == %d", 123)
            let persistedUserWithID = try PersistenceController.object(User.self, withPredicate: predicateWithID)
            XCTAssertEqual(user1.id, persistedUserWithID?.id, "The user that was fetched is not the expected user.")
            
            let predicateWithEmail = NSPredicate(format: "email == %@", "email2@domain.tld")
            let persisteduserWithBody = try PersistenceController.object(User.self, withPredicate: predicateWithEmail)
            XCTAssertEqual(user2.email, persisteduserWithBody?.email, "The user that was fetched is not the expected user.")
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    func testFetchObjects() {
        let tweets = self.tweets()
        let tweet1 = tweets[0]
        let tweet2 = tweets[1]
        let tweet3 = tweets[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([tweet1, tweet2, tweet3], update: true)
            })
            
            let persistedTweets = try PersistenceController.objects(Tweet.self)
            XCTAssert(persistedTweets?.contains{$0 == tweet1} ?? false, "The persisted tweets must contain tweet1.")
            XCTAssert(persistedTweets?.contains{$0 == tweet2} ?? false, "The persisted tweets must contain tweet2.")
            XCTAssert(persistedTweets?.contains{$0 == tweet3} ?? false, "The persisted tweets must contain tweet3.")
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
        
        let users = self.users()
        let user1 = users[0]
        let user2 = users[1]
        let user3 = users[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([user1, user2, user3], update: true)
            })
            
            let persistedUsers = try PersistenceController.objects(User.self)
            XCTAssert(persistedUsers?.contains{$0 == user1} ?? false, "The persisted users must contain user1.")
            XCTAssert(persistedUsers?.contains{$0 == user2} ?? false, "The persisted users must contain user2.")
            XCTAssert(persistedUsers?.contains{$0 == user3} ?? false, "The persisted users must contain user3.")
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    func testFetchObjectsWithPredicate() {
        let tweets = self.tweets()
        let tweet1 = tweets[0]
        let tweet2 = tweets[1]
        let tweet3 = tweets[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([tweet1, tweet2, tweet3], update: true)
            })
            
            let predicateWithID = NSPredicate(format: "id > %d", 123)
            if let persistedTweets = try PersistenceController.objects(Tweet.self, withPredicate: predicateWithID) {
                for tweet in persistedTweets {
                    XCTAssert(tweet.id > 123, "The tweet id must be greater than 123.")
                }
                XCTAssert(persistedTweets.count == 2, "The number of tweets should be 2.")
            } else {
                XCTFail("The tweets must be persisted.")
            }
            
            let predicateWithBody = NSPredicate(format: "body BEGINSWITH %@", "H")
            if let persistedTweets = try PersistenceController.objects(Tweet.self, withPredicate: predicateWithBody) {
                for tweet in persistedTweets {
                    let h = tweet.body[tweet.body.startIndex.advancedBy(0)]
                    XCTAssert(h == "H", "The tweet body must start with H. Actual: \(h)")
                }
                XCTAssert(persistedTweets.count == 2, "The number of tweets should be 2.")
            } else {
                XCTFail("The tweets must be persisted.")
            }
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
        
        let users = self.users()
        let user1 = users[0]
        let user2 = users[1]
        let user3 = users[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([user1, user2, user3], update: true)
            })
            
            let predicateWithID = NSPredicate(format: "id < %d", 789)
            if let persistedUsers = try PersistenceController.objects(User.self, withPredicate: predicateWithID) {
                for user in persistedUsers {
                    XCTAssert(user.id < 789, "The user id must be greater than 123.")
                }
                XCTAssert(persistedUsers.count == 2, "The number of users should be 2.")
            } else {
                XCTFail("The users must be persisted.")
            }
            
            let predicateWithBody = NSPredicate(format: "email BEGINSWITH %@", "email")
            if let persistedUsers = try PersistenceController.objects(User.self, withPredicate: predicateWithBody) {
                for user in persistedUsers {
                    let email = user.email.substringToIndex(user.email.startIndex.advancedBy(5))  //[user.email.startIndex.advancedBy(4)]
                    XCTAssert(email == "email", "The user email must start with 'email'. Actual: \(email)")
                }
                XCTAssert(persistedUsers.count == 2, "The number of tweets should be 2.")
            } else {
                XCTFail("The users must be persisted.")
            }
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    func testFetchObjectsSorted() {
        let tweets = self.tweets()
        let tweet1 = tweets[0]
        let tweet2 = tweets[1]
        let tweet3 = tweets[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([tweet3, tweet1, tweet2], update: true)
            })
            
            if let persistedTweets = try PersistenceController.objects(Tweet.self, sortedByProperty: "body", ascending: true) {
                XCTAssert(persistedTweets[0].body == "Bonjour Monde!", "The tweet is not the expected tweet.")
                XCTAssert(persistedTweets[1].body == "Hello World!", "The tweet is not the expected tweet.")
                XCTAssert(persistedTweets[2].body == "Hola Mundo!", "The tweet is not the expected tweet.")
            } else {
                XCTFail("The tweets must be persisted.")
            }
            
            if let persistedTweets = try PersistenceController.objects(Tweet.self, sortedByProperty: "id", ascending: false) {
                XCTAssert(persistedTweets[0].id == 789, "The tweet is not the expected tweet.")
                XCTAssert(persistedTweets[1].id == 456, "The tweet is not the expected tweet.")
                XCTAssert(persistedTweets[2].id == 123, "The tweet is not the expected tweet.")
            } else {
                XCTFail("The tweets must be persisted.")
            }
            
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
        
        let users = self.users()
        let user1 = users[0]
        let user2 = users[1]
        let user3 = users[2]
        
        do {
            try self.realm()?.write({ () -> Void in
                self.realm()?.add([user3, user1, user2], update: true)
            })
            
            if let persistedUsers = try PersistenceController.objects(User.self, sortedByProperty: "email", ascending: false) {
                XCTAssert(persistedUsers[0].email == "email3@domain.tld", "The user is not the expected user.")
                XCTAssert(persistedUsers[1].email == "email1@domain.tld", "The user is not the expected user.")
                XCTAssert(persistedUsers[2].email == "courriel2@domain.tld", "The user is not the expected user.")
            } else {
                XCTFail("The users must be persisted.")
            }
            
            if let persistedUsers = try PersistenceController.objects(User.self, sortedByProperty: "id", ascending: true) {
                XCTAssert(persistedUsers[0].id == 123, "The user is not the expected user.")
                XCTAssert(persistedUsers[1].id == 456, "The user is not the expected user.")
                XCTAssert(persistedUsers[2].id == 789, "The user is not the expected user.")
            } else {
                XCTFail("The users must be persisted.")
            }
            
        } catch let error as NSError {
            XCTFail("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
    }
    
    // MARK: - Utilities
    
    private func entities() -> (tweet: Tweet, user: User) {
        let tweetDictionary = [
            "body": "Hello World!",
            "created_date": "1970-01-01T00:00:00 +0000",
            "favourite_count": 12345,
            "id": 999,
            "retweet_count": 56789,
        ]
        let tweet = Tweet(dictionary: tweetDictionary)
        
        let userDictionary = [
            "email": "email@domain.tld",
            "first_name": "first_name",
            "id": 999,
            "last_name": "last_name",
            "password": "password",
            "username": "username",
        ]
        let user = User(dictionary: userDictionary)
        
        return (tweet: tweet, user: user)
    }
    
    private func realm() -> Realm? {
        do {
            let config = Realm.Configuration(inMemoryIdentifier: NSStringFromClass(PersistenceControllerTests.self))
            return try Realm(configuration: config)
        } catch let error as NSError {
            print("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            return nil
        }
    }
    
    private func tweets() -> [Tweet] {
        let tweet1Dictionary = [
            "body": "Hello World!",
            "created_date": "1970-01-01T00:00:00 +0000",
            "favourite_count": 12345,
            "id": 123,
            "retweet_count": 56789,
        ]
        let tweet1 = Tweet(dictionary: tweet1Dictionary)
        
        let tweet2Dictionary = [
            "body": "Bonjour Monde!",
            "created_date": "1970-01-01T00:00:00 +0000",
            "favourite_count": 12345,
            "id": 456,
            "retweet_count": 56789,
        ]
        let tweet2 = Tweet(dictionary: tweet2Dictionary)
        
        let tweet3Dictionary = [
            "body": "Hola Mundo!",
            "created_date": "1970-01-01T00:00:00 +0000",
            "favourite_count": 12345,
            "id": 789,
            "retweet_count": 56789,
        ]
        let tweet3 = Tweet(dictionary: tweet3Dictionary)
        
        return [tweet1, tweet2, tweet3]
    }
    
    private func users() -> [User] {
        let user1Dictionary = [
            "email": "email1@domain.tld",
            "first_name": "first_name1",
            "id": 123,
            "last_name": "last_name1",
            "password": "password1",
            "username": "username1",
        ]
        let user1 = User(dictionary: user1Dictionary)
        
        let user2Dictionary = [
            "email": "email3@domain.tld",
            "first_name": "first_name2",
            "id": 456,
            "last_name": "last_name2",
            "password": "password2",
            "username": "username2",
        ]
        let user2 = User(dictionary: user2Dictionary)
        
        let user3Dictionary = [
            "email": "courriel2@domain.tld",
            "first_name": "first_name3",
            "id": 789,
            "last_name": "last_name3",
            "password": "password3",
            "username": "username3",
        ]
        let user3 = User(dictionary: user3Dictionary)
        
        return [user1, user2, user3]
    }
    
}
