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
    var screenName: String
    var isFavorited: Bool
    var tweetID: String!
    var _createAt: String!
    var createAt: String? {
        get {
            let df = NSDateFormatter()
            //Wed Dec 01 17:08:03 +0000 2010
            df.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
            let date = df.dateFromString(_createAt)
            df.dateFormat = "M/dd/yy, HH:mm:ss a"
            let dateStr = df.stringFromDate(date!)
            return dateStr
        }
        
    }
   
    
    
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as! String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["user"]!["favourites_count"] as? Int) ?? 0
        
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
        
        screenName = dictionary["user"]!["screen_name"] as! String
        
        _createAt = dictionary["created_at"] as! String
        
        isFavorited = dictionary["favorited"] as! Bool
        
        tweetID = dictionary["id_str"] as! String
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
