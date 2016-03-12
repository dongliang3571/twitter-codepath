//
//  DetailTableViewCell.swift
//  twitter_codepath
//
//  Created by dong liang on 3/11/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!

    @IBOutlet weak var createAt: UILabel!
    
    
    
    var tweet: Tweet! {
        didSet {
            if let tweet = tweet {
                print(tweet)
                
                print("table is set")
                profile_image.setImageWithURL((tweet.profileImage)!)
                
                screenName.text = tweet.username
                userName.text = "@\((tweet.screenName))"
                tweetText.text = tweet.text
                tweetText.sizeToFit()
                
                createAt.text = tweet.createAt
                print(tweet.createAt)
                
                print("table set is finished")
            }
            
        }
    }
    
//    init(tweet: Tweet) {
//        self.tweet = tweet
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
