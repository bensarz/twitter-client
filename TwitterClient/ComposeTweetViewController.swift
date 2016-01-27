//
//  ComposeTweetViewController.swift
//  TwitterClient
//
//  Created by Benoit Sarrazin on 2016-01-27.
//  Copyright © 2016 Berzerker IO. All rights reserved.
//

import Log
import UIKit

class ComposeTweetViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView?.layer.cornerRadius = 5
        }
    }
    
    // MARK: - Properties
    
    var completion: ((tweet: Tweet?) -> ())?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        updateCharacterCountLabel()
    }
    
    override func viewWillDisappear(animated: Bool) {
        textView.resignFirstResponder()
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        completion?(tweet: nil)
    }
    
    @IBAction func tweetButtonTapped(sender: UIButton) {
        if textView.text.isEmpty {
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default, handler: nil)
            let alertController = UIAlertController(
                title: NSLocalizedString("Empty Tweet", comment: ""),
                message: NSLocalizedString("You cannot tweet nothing. Have you ever heard a bird silently chirp?", comment: ""),
                preferredStyle: .Alert)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            let tweet = Tweet()
            tweet.body = textView.text ?? ""
            completion?(tweet: tweet)
        }
    }
    
    // MARK: - UI Utils
    
    private func updateCharacterCountLabel() {
        characterCountLabel.text = "\(textView.text.characters.count) characters"
    }
    
}

extension ComposeTweetViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        updateCharacterCountLabel()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // [BS] Jan 27, 2016
        // We always allow characters until we hit 140 characters.
        // If the text view has 140 but there is a selection that starts prior to location 140
        // and it actually selects at least one character, then allow that new character to be inserted.
        let allowAnotherCharacter = range.length + range.location < 140
        let hasSelection = range.location < 140 && range.location - range.length != 0
        return allowAnotherCharacter || (!allowAnotherCharacter && hasSelection)
    }
    
}
