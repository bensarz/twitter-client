//
//  NSDateFormatter+Extensions.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation

extension NSDateFormatter {
    
    static var defaultDateFormatter: NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = DateFormats.kDefault
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return dateFormatter
    }
    
    static var iso8601DateFormatter: NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = DateFormats.kISO8601
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return dateFormatter
    }
    
    static var simpleDateFormatter: NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = DateFormats.kSimple
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        return dateFormatter
    }

    
}