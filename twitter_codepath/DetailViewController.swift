//
//  DetailViewController.swift
//  twitter_codepath
//
//  Created by dong liang on 3/9/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var DetailTableView: UITableView!

    static let shareInstance = DetailViewController()
    
    var tweet: Tweet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailTableView.dataSource = self
        DetailTableView.delegate = self
        DetailTableView.rowHeight = UITableViewAutomaticDimension
        DetailTableView.estimatedRowHeight = 120
        DetailTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if let _ = tweet {
            
            DetailTableView.reloadData()
        }
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserverForName("retweetChanged", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            print("tweet changed")
            self.DetailTableView.reloadData()
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("likeChanged", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            print("tweet changed")
            self.DetailTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    

    
    
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = DetailTableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath:
                indexPath) as! DetailTableViewCell
            
            cell.tweet = tweet
            
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: Selector("imageTapped:"))
            
            cell.profile_image.userInteractionEnabled = true
            cell.profile_image.addGestureRecognizer(tapGestureRecognizer)
            
            return cell
        }
        
        else if indexPath.row == 1 {
            let cell = DetailTableView.dequeueReusableCellWithIdentifier("RetweetCell", forIndexPath:
                indexPath) as! RetweetTableViewCell
            let id = tweet?.tweetID
            TwitterClient.shareInstance.getSingleTweet({ (tweet: Tweet) -> () in
                cell.retweet.text = "\(tweet.retweetCount)"
                cell.favorites.text = "\(tweet.favoriteCount)"
                }, failure: { (error: NSError) -> () in
                    print(error)
                }, tweetID: id!)

            return cell
        }
        
        else if indexPath.row == 2 {
            let cell = DetailTableView.dequeueReusableCellWithIdentifier("ReplyCell", forIndexPath:
                indexPath) as! ReplyTableViewCell
            
            cell.tweetID = tweet?.tweetID
//            print(cell.tweetID)
            
            TwitterClient.shareInstance.getSingleTweet({ (tweet: Tweet) -> () in
                cell.isFavorited = tweet.isFavorited
                cell.retweeted = tweet.retweeted
                }, failure: { (error: NSError) -> () in
                    print(error)
                }, tweetID: cell.tweetID!)
            
//            cell.isFavorited = tweet?.isFavorited
//            cell.retweeted = tweet?.retweeted
            
            return cell
        }
        
        else {
            let cell = DetailTableView.dequeueReusableCellWithIdentifier("RetweetCell", forIndexPath:
                indexPath)
            
            return cell
        }

        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func imageTapped(img: AnyObject) {
        self.performSegueWithIdentifier("profileSegue", sender: self)
        
    }
    
    
}
