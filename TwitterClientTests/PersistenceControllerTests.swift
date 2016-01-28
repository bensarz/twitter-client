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
    
    // MARK: - Utilities
    
    private func realm() -> Realm? {
        do {
            let config = Realm.Configuration(inMemoryIdentifier: NSStringFromClass(PersistenceControllerTests.self))
            return try Realm(configuration: config)
        } catch let error as NSError {
            print("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            return nil
        }
    }
    
}
