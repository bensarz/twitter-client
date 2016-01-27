//
//  UserTests.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import XCTest
@testable import TwitterClient

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultValues() {
        let user = User()
        XCTAssertEqual(user.email, "", "The user has the wrong default email.")
        XCTAssertEqual(user.firstName, "", "The user has the wrong default first name.")
        XCTAssertEqual(user.id, 0, "The user has the wrong default id.")
        XCTAssertEqual(user.lastName, "", "The user has the wrong default last name.")
        XCTAssertEqual(user.password, "", "The user has the wrong default password.")
        XCTAssertEqual(user.username, "", "The user has the wrong default username.")
    }
    
    func testInitPasswordUsername() {
        let username = "username"
        let password = "password"
        let user = User(password: password, username: username)
        XCTAssertEqual(user.password, "password", "The password does not match.")
        XCTAssertEqual(user.password, password, "The password does not match.")
        XCTAssertEqual(user.username, "username", "The username does not match.")
        XCTAssertEqual(user.username, username, "The username does not match.")
    }
    
    func testInitDictionary() {
        let dictionary = [
            "email": "email@domain.tld",
            "first_name": "first_name",
            "id": 999,
            "last_name": "last_name",
            "password": "password",
            "username": "username",
        ]
        
        let user = User(dictionary: dictionary)
        XCTAssertEqual(user.email, dictionary["email"], "The email does not match.")
        XCTAssertEqual(user.email, "email@domain.tld", "The email does not match.")
        XCTAssertEqual(user.firstName, dictionary["first_name"], "The first name does not match.")
        XCTAssertEqual(user.firstName, "first_name", "The first name does not match.")
        XCTAssertEqual(user.id, dictionary["id"], "The id does not match.")
        XCTAssertEqual(user.id, 999, "The id does not match.")
        XCTAssertEqual(user.lastName, dictionary["last_name"], "The last name does not match.")
        XCTAssertEqual(user.lastName, "last_name", "The last name does not match.")
        XCTAssertEqual(user.password, "", "The password must be empty.") // The password must not be saved when using a dictionary.
        XCTAssertEqual(user.username, dictionary["username"], "The username does not match.")
        XCTAssertEqual(user.username, "username", "The username does not match.")
    }
    
    func testParsingKeys() {
        XCTAssertEqual(User.ParsingKey.Email.rawValue, "email", "The parsing key 'email' is invalid.")
        XCTAssertEqual(User.ParsingKey.FirstName.rawValue, "first_name", "The parsing key 'first_name' is invalid.")
        XCTAssertEqual(User.ParsingKey.ID.rawValue, "id", "The parsing key 'id' is invalid.")
        XCTAssertEqual(User.ParsingKey.LastName.rawValue, "last_name", "The parsing key 'last_name' is invalid.")
        XCTAssertEqual(User.ParsingKey.Username.rawValue, "username", "The parsing key 'username' is invalid.")
    }
    
    func testRealm() {
        XCTAssertEqual(User.primaryKey(), "id", "The primary key is invalid.")
        XCTAssertEqual(User.ignoredProperties(), ["password"], "The ignored properties are invalid.")
    }
    
}
