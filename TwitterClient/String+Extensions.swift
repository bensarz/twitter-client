//
//  String+Extensions.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation

extension String {
    
    var defaultDateValue: NSDate? {
        let dateFormatter = NSDateFormatter.defaultDateFormatter
        let date = dateFormatter.dateFromString(self)
        return date
    }
    
    var ISO8601DateValue: NSDate? {
        let dateFormatter = NSDateFormatter.iso8601DateFormatter
        let date = dateFormatter.dateFromString(self)
        return date
    }
    
    var simpleDateValue: NSDate? {
        let dateFormatter = NSDateFormatter.simpleDateFormatter
        let date = dateFormatter.dateFromString(self)
        return date
    }
    
}