//
//  LoginViewController.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-26.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Log
import SVProgressHUD
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var completion: ((error: NSError?, user: User?) -> ())?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton?.layer.cornerRadius = 5
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func signInButtonTapped(sender: UIButton) {
        
        // [BS] Jan 26, 2016
        // We assume that there no character limitations for usernames and passwords.
        // Otherwise, we would perform some validation here or implement `UITextFieldDelegate`
        // and perform validation on the fly.
        
        guard let username = usernameTextField.text where !username.isEmpty else {
            let message = NSLocalizedString("Your username cannot be empty.", comment: "")
            let title = NSLocalizedString("Username", comment: "")
            presentErrorMessage(message, withTitle: title)
            return
        }
        
        guard let password = passwordTextField.text where !password.isEmpty else {
            let message = NSLocalizedString("Your password cannot be empty.", comment: "")
            let title = NSLocalizedString("Password", comment: "")
            presentErrorMessage(message, withTitle: title)
            return
        }
        
        SVProgressHUD.showWithMaskType(.Gradient)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { () -> Void in
            let user = User()
            user.username = username
            user.password = password
            UserModelService.authenticateUser(user, completion: { (error, user) -> () in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    SVProgressHUD.dismiss()
                }
                
                if let error = error {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                    })
                } else if let user = user {
                    // [BS] Jan 26, 2016
                    // At this point, we're only going to allow the user to leave this screen
                    // if he/she has succesfully logged in.
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        SVProgressHUD.showSuccessWithStatus("Success!")
                    })
                    self.completion?(error: nil, user: user)
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        SVProgressHUD.showErrorWithStatus("A terrible error occurred.")
                    })
                }
            })
        }
        
    }
    
    // MARK: - UI Utilities
    
    private func presentErrorMessage(message: String, withTitle title: String) {
        let okActionTitle = NSLocalizedString("OK", comment: "")
        let okAction = UIAlertAction(title: okActionTitle, style: .Default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}
