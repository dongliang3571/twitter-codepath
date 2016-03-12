//
//  TwitterClient.swift
//  twitter_codepath
//
//  Created by dong liang on 2/29/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let shareInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "IgE3avPqJpwOVg9HVs5RyPYSD", consumerSecret: "5o141ARSRUUP1nWq3y7fbHUPeFdFAMyg4w8Dyxv3gSvVdOqW5F")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.shareInstance.deauthorize()
        TwitterClient.shareInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitteruse://auth"), scope: nil, success: { (requesttoken:BDBOAuth1Credential!) -> Void in
            print("I got request token....")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requesttoken.token)")!
            print("I'm openning the url with request token.....")
            UIApplication.sharedApplication().openURL(url)
            }) { (error: NSError!) -> Void in
                self.loginFailure?(error)
        }
    }

    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userdidLogout, object: nil)
    }
    
    
    func handleOpenUrl(url: NSURL) {
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            

            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user

                self.loginSuccess?()
                
                }, failure: { (error: NSError) -> () in
                    print("error: \(error.localizedDescription)")
                    self.loginFailure?(error)
            })
            
            
            
            }) { (error: NSError!) -> Void in
                print("I got error")
                self.loginFailure?(error)
        }
    }
    
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as! [NSDictionary]

            let tweets = Tweet.tweetWithArray(dictionaries)
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
        
        
        
    }
    
    func retweetAction(success: (NSDictionary) -> (), failure: (NSError) -> (), tweetID: String) {
        
        POST("1.1/statuses/retweet/\(tweetID).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionary = response as! NSDictionary
            
            success(dictionary)
            
            
            
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        }
    }
    
    func toLikeAction(success: (NSDictionary) -> (), failure: (NSError) -> (), tweetID: String) {
        
        POST("1.1/favorites/create.json?id=\(tweetID)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionary = response as! NSDictionary
            success(dictionary)
            
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        }
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary

            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    
    
}
