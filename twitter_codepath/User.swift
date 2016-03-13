//
//  User.swift
//  twitter_codepath
//
//  Created by dong liang on 2/29/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screennname: String?
    var profileUrl: NSURL?
    var tagline: String?
    
    var followers: Int = 0
    var following: Int = 0
    var totalTweets: Int = 0
    
    var dictionary: NSDictionary?
    
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screennname = dictionary["screen_name"] as? String
        
        let profileUrlstring = dictionary["profile_image_url_https"] as? String
        
        if let profileUrlstring = profileUrlstring {
            profileUrl = NSURL(string: profileUrlstring)
        }
        
        tagline = dictionary["description"] as? String
        
        
        followers = (dictionary["followers_count"] as? Int) ?? 0
        
        following = (dictionary["friends_count"] as? Int) ?? 0
        
        totalTweets = (dictionary["statuses_count"] as? Int) ?? 0
    }
    
    static var userdidLogout = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                
                let userData = defaults.objectForKey("currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }

            return _currentUser
        }
        
        set(user) {
            
            print("im setting account")
            _currentUser = user
            
            print("\(user?.name)")
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")

            }
            
            
            defaults.synchronize()
        }
    }
    
}
