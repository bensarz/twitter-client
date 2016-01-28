//
//  DateFormatsTests.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import XCTest
@testable import TwitterClient

class DateFormatsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstants() {
        XCTAssertEqual(DateFormats.kDefault, "yyyy-MM-dd' 'HH:mm:ss", "The default date format is invalid.")
        XCTAssertEqual(DateFormats.kISO8601, "yyyy-MM-dd'T'HH:mm:ssZ", "The ISO8601 date format is invalid.")
        XCTAssertEqual(DateFormats.kSimple, "yyyy-MM-dd", "The simple date format is invalid.")
    }
    
}
