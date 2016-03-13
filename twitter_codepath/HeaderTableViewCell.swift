//
//  HeaderTableViewCell.swift
//  twitter_codepath
//
//  Created by dong liang on 3/13/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var screennamLabel: UILabel!
    
    @IBOutlet weak var tweetNumberLabel: UILabel!
    
    
    @IBOutlet weak var followingNumberLabel: UILabel!
    
    @IBOutlet weak var followerNumberLabel: UILabel!
    
    var user: User? {
        didSet {
            profileImage.setImageWithURL((user!.profileUrl)!)
            
            nameLabel.text = user!.name
            
            screennamLabel.text = "@\(user!.screennname!)"
            
            tweetNumberLabel.text = "\(user!.totalTweets)"
            
            followerNumberLabel.text = "\(user!.followers)"
            
            followingNumberLabel.text = "\(user!.following)"
            
            
            
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
