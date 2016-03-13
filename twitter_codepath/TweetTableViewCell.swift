//
//  TweetTableViewCell.swift
//  twitter_codepath
//
//  Created by dong liang on 3/5/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit
import AFNetworking


@objc protocol SegProfileDelegate {
    optional func goToProfile(cell: TweetTableViewCell)
}

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    weak var delegate: SegProfileDelegate?
    
    var tweet: Tweet! {
        didSet {
            tweetText.text = tweet.text
            username.text = tweet.username
            profileImage.setImageWithURL(tweet.profileImage!)
            tweetText.sizeToFit()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: Selector("imageTapped"))
        
        profileImage.userInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func imageTapped() {
        print("home profile image is clicked")
        if self.delegate != nil {
            delegate!.goToProfile?(self)
        }
        
    }
}
