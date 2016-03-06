//
//  TweetTableViewCell.swift
//  twitter_codepath
//
//  Created by dong liang on 3/5/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit
import AFNetworking

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetText.text = tweet.text
            username.text = tweet.username
            profileImage.setImageWithURL(tweet.profileImage!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
