//
//  NSDateExtensionsTests.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import XCTest
@testable import TwitterClient

class NSDateExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultStringValue() {
        // [BS] Jan 27, 2016
        // It is important to note that this test is meant to run in EST/EDT.
        // This is not perfect but nor are the extensions on `NSDate` and `String` related to dates.
        let date = NSDate(timeIntervalSince1970: 0)
        if let defaultStringValue = date.defaultStringValue {
            XCTAssertEqual(defaultStringValue, "1969-12-31 19:00:00", "The default string value is invalid.")
        } else {
            XCTFail("The default string value is nil.")
        }
    }
    
    func testISO8601StringValue() {
        // [BS] Jan 27, 2016
        // It is important to note that this test is meant to run in EST/EDT.
        // This is not perfect but nor are the extensions on `NSDate` and `String` related to dates.
        let date = NSDate(timeIntervalSince1970: 0)
        if let defaultStringValue = date.ISO8601StringValue {
            XCTAssertEqual(defaultStringValue, "1969-12-31T19:00:00-0500", "The default string value is invalid.")
        } else {
            XCTFail("The default string value is nil.")
        }
    }
    
    func testSimpleStringValue() {
        // [BS] Jan 27, 2016
        // It is important to note that this test is meant to run in EST/EDT.
        // This is not perfect but nor are the extensions on `NSDate` and `String` related to dates.
        let date = NSDate(timeIntervalSince1970: 0)
        if let defaultStringValue = date.simpleStringValue {
            XCTAssertEqual(defaultStringValue, "1969-12-31", "The default string value is invalid.")
        } else {
            XCTFail("The default string value is nil.")
        }
    }
    
}
