//
//  PersistenceController.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import Log
import RealmSwift

class PersistenceController {
    
    // MARK: - Properties
    
    /// The default Realm object where everything is persisted.
    private class var realm: Realm? {
        do {
            return try Realm()
        } catch let error as NSError {
            Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
        }
        return nil
    }
    
    // MARK: - CRUD Operations
    
    /**
    Fetches the first object of type `T` in the Realm.
    
    - parameter type:      The type of object to fetch.
    - parameter predicate: A predicate used to filter the result.
    
    - throws: Throws an `NSError` if the fetch cannot be completed.
    
    - returns: Returns the first object of type `T` that is persisted in the Realm.
    */
    class func object<T>(type: T.Type, withPredicate predicate: NSPredicate? = nil) throws -> T? {
        if let type = type as? Object.Type {
            if let predicate = predicate {
                return realm?.objects(type).filter(predicate).first as? T
            } else {
                return realm?.objects(type).first as? T
            }
        } else {
            let error = NSError(
                domain: NSStringFromClass(self),
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("The object received does not inherit from `RealmSwift.Object`.", comment: "")])
            throw error
        }
    }
    
    /**
     Fetches objects of type `T` in the Realm.
     
     - parameter type:             The type of objects to fetch.
     - parameter predicate:        A predicate used to filter results.
     - parameter sortedByProperty: A property used as a sort descriptor.
     - parameter ascending:        The direction of the sort descriptor.
     
     - throws: Throws an `NSError` if the fetch cannot be completed.
     
     - returns: Returns an array of objects of type `T` that are persisted in the Realm.
     */
    class func objects<T>(type: T.Type, withPredicate predicate: NSPredicate? = nil, sortedByProperty: String? = nil, ascending: Bool = true) throws -> [T]? {
        if let type = type as? Object.Type, let realm = realm {
            var results: Results<Object>
            if let predicate = predicate where sortedByProperty == nil {
                results = realm.objects(type).filter(predicate)
            } else if let propertyToSortBy = sortedByProperty {
                results = realm.objects(type).sorted(propertyToSortBy, ascending: ascending)
                if let predicate = predicate {
                    results = results.filter(predicate)
                }
            } else {
                results = realm.objects(type)
            }
            
            var objects = [T]()
            for i in 0..<results.count {
                if let result = results[i] as? T {
                    objects.append(result)
                }
            }
            
            return objects
        } else {
            let error = NSError(
                domain: NSStringFromClass(self),
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("The object received does not inherit from `RealmSwift.Object`.", comment: "")])
            throw error
        }
    }
    
    /**
     Persists or updates objects withing the Realm.
     Objects are updated if they declare a primary key.
     
     - parameter objects: An array of objects to be persisted or updated.
     
     - throws: Throws an `NSError` if the object(s) cannot be persisted.
     */
    class func persistOrUpdateObjects(objects: [Object]) throws -> Void {
        do {
            try realm?.write({ () -> Void in
                realm?.add(objects, update: true)
            })
        } catch let error as NSError {
            Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            throw error as ErrorType
        }
    }
    
    /**
     Updates a previously persisted object in a transaction.
     
     - parameter transaction: The block to execute witing a transaction.
     
     - throws: Throws an `NSError` if the transaction cannot be completed.
     */
    class func updateUsing(transaction: () -> ()) throws -> Void {
        do {
            try realm?.write({ () -> Void in
                transaction()
            })
        } catch let error as NSError {
            Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            throw error
        }
    }
    
    // MARK: - Notifications
    
    /**
    Adds a notification block to Realm's notification system.
    
    - parameter block: The block to execute when a notification is posted.
    
    - returns: An opaque object identifying the notification block. You must persist this token and it must be used to remove the notification block.
    */
    class func addNotificationBlock(block: (() -> ())) -> NSObject {
        return realm?.addNotificationBlock({ (notification, realm) -> Void in
            block()
        }) ?? NSObject()
    }
    
    /**
     Removes a notification block from Realm's notification system.
     
     - parameter token: The token of the notification to remove.
     */
    class func removeNotificationBlock(token: NSObject) -> Void {
        if let token = token as? NotificationToken {
            realm?.removeNotification(token)
        }
    }
}
