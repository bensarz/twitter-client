//
//  ModelService.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation

class ModelService {
    
    /**
     Adds a notification block to the persistence layer.
     This block will be called if any changes occured in the persistence layer.
     
     - parameter block: The block to execute when a change occurs.
     
     - returns: An opaque object used as a token to remove the notification block.
     */
    class func addNotificationBlock(block: (() -> ())?) -> NSObject {
        return PersistenceController.addNotificationBlock { () -> () in
            block?()
        }
    }
    
    /**
     Removes a notification block from the persistence layer.
     
     - parameter token: The token identifying which block to remove.
     */
    class func removeNotificationBlockIdentifiedByToken(token: NSObject) -> Void {
        PersistenceController.removeNotificationBlock(token)
    }
    
}
