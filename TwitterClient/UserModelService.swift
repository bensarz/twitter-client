//
//  UserModelService.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Foundation
import Log

class UserModelService: ModelService {
    
    /**
     Fetch the user that is currently logged into the application.
     
     - returns: Return the exising user if any.
     */
    class func existingUser() -> User? {
        do {
            return try PersistenceController.object(User.self)
        } catch let error as NSError {
            Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            return nil
        }
    }
    
    /**
     Authenticates a user based on the combination of their username and password against the `TwitterNetworkService`.
     
     - parameter user:       The user to authenticate.
     - parameter completion: The completion closure called once the operation completes.
     */
    class func authenticateUser(user: User, completion: ((error: NSError?, user: User?) -> ())?) {
        TwitterNetworkService.authenticateUser(user) { (error, user) -> () in
            do {
                if let user = user {
                    try PersistenceController.persistOrUpdateObjects([user])
                }
                completion?(error: error, user: user)
            } catch let error as NSError {
                Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
                completion?(error: error, user: user)
            }
        }
    }
    
    /**
     Fetches a user with a given username in the persistence store.
     
     - parameter username: The username of the user.
     
     - returns: Return the user with a given username if found, nil otherwise.
     */
    class func userWithUsername(username: String) -> User? {
        do {
            let predicate = NSPredicate(format: "username == %@", username)
            return try PersistenceController.object(User.self, withPredicate: predicate)
        } catch let error as NSError {
            Log.error("Error: \(error.code) \(error.localizedDescription) \(error.userInfo)")
            return nil
        }
    }
    
}
