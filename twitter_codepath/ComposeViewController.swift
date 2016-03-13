//
//  ComposeViewController.swift
//  twitter_codepath
//
//  Created by dong liang on 3/13/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func CancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    
    
    @IBAction func sendPressed(sender: AnyObject) {
        
        let text = self.text.text
        
        TwitterClient.shareInstance.publishTweet({ (tweet: Tweet) -> () in
            print(tweet)
            }, failure: { (error: NSError) -> () in
                print(error)
            }, text: text)
        
        dismissViewControllerAnimated(true, completion: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("refreshhome", object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
