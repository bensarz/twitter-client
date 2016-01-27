//
//  StringExtensionsTests.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import XCTest
@testable import TwitterClient

class StringExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultDateValue() {
        // [BS] Jan 27, 2016
        // It is important to note that this test is meant to run in EST/EDT.
        // This is not perfect but nor are the extensions on `NSDate` and `String` related to dates.
        let string = "1969-12-31 19:00:00"
        if let date = string.defaultDateValue {
            XCTAssertEqual(date, NSDate(timeIntervalSince1970: 0), "The default date value is invalid.")
        } else {
            XCTFail("The default date value must not be nil.")
        }
    }
    
    func testISO8601DateValue() {
        // [BS] Jan 27, 2016
        // It is important to note that this test is meant to run in EST/EDT.
        // This is not perfect but nor are the extensions on `NSDate` and `String` related to dates.
        let string = "1969-12-31T19:00:00-0500"
        if let date = string.ISO8601DateValue {
            XCTAssertEqual(date, NSDate(timeIntervalSince1970: 0), "The ISO8601 date value is invalid.")
        } else {
            XCTFail("The ISO8601 date value must not be nil.")
        }
    }
    
    func testSimpleDateValue() {
        // [BS] Jan 27, 2016
        // It is important to note that this test is meant to run in EST/EDT.
        // This is not perfect but nor are the extensions on `NSDate` and `String` related to dates.
        let string = "1970-01-01"
        if let date = string.simpleDateValue {
            let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            XCTAssertEqual(calendar.startOfDayForDate(date), NSDate(timeIntervalSince1970: 0), "The simple date value is invalid.")
        } else {
            XCTFail("The simple date value must not be nil.")
        }
    }
    
}
