//
//  ReplyTableViewCell.swift
//  twitter_codepath
//
//  Created by dong liang on 3/12/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var reply: UIButton!


    @IBOutlet weak var retweet: UIButton!
    
    
    @IBOutlet weak var favorite: UIButton!
    
    var tweetID: String?
    
    var isFavorited: Bool? {
        didSet {
            if let isFavorited = isFavorited {
                if isFavorited {
                    favorite.setImage(UIImage(named: "like-action-on"), forState:UIControlState.Normal)
                    favorite.tintColor = UIColor.redColor()
                } else {
                    favorite.setImage(UIImage(named: "like-action"), forState:UIControlState.Normal)
                }
                favorite.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
    var retweeted: Bool? {
        didSet {
            if let retweeted = retweeted {
                if retweeted {
                    retweet.setImage(UIImage(named: "retweet-action"), forState:UIControlState.Normal)
                    retweet.tintColor = UIColor.redColor()
                } else {
                    retweet.setImage(UIImage(named: "retweet-action"), forState:UIControlState.Normal)
                }
                retweet.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reply.setImage(UIImage(named: "reply-action-pressed"), forState:UIControlState.Normal)
        reply.setTitle("", forState: UIControlState.Normal)
        
//        retweet.setImage(UIImage(named: "retweet-action"), forState:UIControlState.Normal)
//        retweet.setTitle("", forState: UIControlState.Normal)
        

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func retweetButtonPressed(sender: AnyObject) {
        TwitterClient.shareInstance.retweetAction({ (dictionary: NSDictionary) -> () in
//            print(dictionary)
            self.retweet.tintColor = UIColor.redColor()
            }, failure: { (error:NSError) -> () in
                print(error)
            }, tweetID: self.tweetID!)
    }
    
    
    
    @IBAction func likeButtonPressed(sender: AnyObject) {
        TwitterClient.shareInstance.toLikeAction({ (dictionary: NSDictionary) -> () in

            self.favorite.tintColor = UIColor.redColor()
            }, failure: { (error: NSError) -> () in
                print(error)
            }, tweetID: self.tweetID!)
    }
    

}
