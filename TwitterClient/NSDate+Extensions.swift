//
//  NSDate+Extensions.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation

extension NSDate {
    
    var defaultStringValue: String? {
        let dateFormatter = NSDateFormatter.defaultDateFormatter
        let string = dateFormatter.stringFromDate(self)
        return string
    }
    
    var ISO8601StringValue: String? {
        let dateFormatter = NSDateFormatter.ISO8601DateFormatter
        let string = dateFormatter.stringFromDate(self)
        return string
    }
    
    var simpleStringValue: String? {
        let dateFormatter = NSDateFormatter.simpleDateFormatter
        let string = dateFormatter.stringFromDate(self)
        return string
    }
    
}