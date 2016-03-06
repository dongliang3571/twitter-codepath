//
//  Tweet.swift
//  twitter_codepath
//
//  Created by dong liang on 2/29/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var profileImage: NSURL?
    var username: String
    
    
    
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as! String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorites_count"] as? Int) ?? 0
        
        let timestampstring = dictionary["create_at"] as? String
        
        if let timestampstring = timestampstring {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampstring)
        }
        
        if let imageurl = (dictionary["user"]!["profile_image_url"] as? String) {
            profileImage = NSURL(string: imageurl)
        }
        
//        profileImage = dictionary["profile_image_url"] as! String
        
        username = dictionary["user"]!["name"] as! String
        
        
    }

    class func tweetWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
