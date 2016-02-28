//
//  LoginViewController.swift
//  twitter_codepath
//
//  Created by dong liang on 2/28/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var onLoginButton: UIButton!

    @IBAction func onLoginPressed(sender: AnyObject) {
        let twitter = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "4nrdZKdOKUWcwRTCxGjYUHqo3", consumerSecret: "APWedULzTeexYaAJtNrTqvWCKERS5dVyrtbDiiJpT8DxS2fbBA")
        
        twitter.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitteruse://auth"), scope: nil, success: { (requesttoken:BDBOAuth1Credential!) -> Void in
            print("I got token")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requesttoken.token)")!
            UIApplication.sharedApplication().openURL(url)
            }) { (error: NSError!) -> Void in
                print("error happened")
        }
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
