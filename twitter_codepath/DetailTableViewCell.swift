//
//  DetailTableViewCell.swift
//  twitter_codepath
//
//  Created by dong liang on 3/11/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit


//@objc protocol SegProfileDelegate {
//    optional func goToProfile()
//}


class DetailTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!

    @IBOutlet weak var createAt: UILabel!
    
//    weak var delegate: SegProfileDelegate?
    
    
    var tweet: Tweet! {
        didSet {
            if let tweet = tweet {
            
                profile_image.setImageWithURL((tweet.profileImage)!)
                
                screenName.text = tweet.username
                userName.text = "@\((tweet.screenName))"
                tweetText.text = tweet.text
                tweetText.sizeToFit()
                
                createAt.text = tweet.createAt
            
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
