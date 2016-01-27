//
//  Log+Extensions.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import Log

extension Formatters {
    
    static let Detailed = Formatter("[%@] %@:%@ %@: %@", [
        .Date("yyyy-MM-dd HH:mm:ss.SSS"),
        .File(fullPath: false, fileExtension: true),
        .Line,
        .Level,
        .Message
        ]
    )
    
}

extension Themes {
    
    static let Yozora = Theme(
        trace:   "#AE81FF", // Purple
        debug:   "#66D9EE", // Blue
        info:    "#A6E22E", // Green
        warning: "#FD971F", // Orange
        error:   "#FF0F5C"  // Pink
    )
    
}
