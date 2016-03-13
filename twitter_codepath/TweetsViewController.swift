//
//  TweetsViewController.swift
//  twitter_codepath
//
//  Created by dong liang on 3/5/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController {

    @IBOutlet weak var mytableView: UITableView!
    
    var tweets: [Tweet]!
    
    var refreshControl: UIRefreshControl!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let image = UIImage(named: "Twitter_logo_blue_32.png")
        self.navigationItem.titleView = UIImageView(image: image!)
        
//        self.tabBarItem.title = "Home"
//        self.tabBarItem.image = UIImage(named: "home")
        mytableView.delegate = self
        mytableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        mytableView.insertSubview(refreshControl, atIndex: 0)
        
        requestHomeTimeLine()

        NSNotificationCenter.defaultCenter().addObserverForName("refreshhome", object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) -> Void in
            print("beginreprsdsad")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.shareInstance.logout()
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
//    func imageTapped(img: AnyObject) {
//        print("home profile image is clicked")
//        self.performSegueWithIdentifier("profileSegue1", sender: self)
//        
//    }

}


extension TweetsViewController: UITableViewDataSource, UITableViewDelegate, SegProfileDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        
//        if let imgUrl = tweets[indexPath.row].profileImage {
//            
//            cell.profileImage.setImageWithURL(imgUrl)
//        }
        
//        cell.tweetText.text =  tweets[1].text as! String
//        let hhaa = tweets[1].text
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: Selector("imageTapped:"))
//        
//        cell.profileImage.userInteractionEnabled = true
//        cell.profileImage.addGestureRecognizer(tapGestureRecognizer)

        
        return cell
    }
    
    func goToProfile(cell: TweetTableViewCell) {
        let index = mytableView.indexPathForCell(cell)
        
        self.performSegueWithIdentifier("profileSegue1", sender: cell)
        print("im cell \(index?.row)")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets  {
            return tweets.count
        } else {
            return 0
        }
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        requestHomeTimeLine()
        
        
    }
    
    func requestHomeTimeLine() {
        TwitterClient.shareInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.mytableView.reloadData()
            self.refreshControl.endRefreshing()
            
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
    }
    
    
//     MARK: - Navigation
//    
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "profileSegue1" {
            
            let cell = sender as! TweetTableViewCell
            
            let indexpath = mytableView.indexPathForCell(cell)
            let tweet = tweets[indexpath!.row]
            print("push to profilesegue1 with index \(indexpath?.row)")
            let profileViewController = segue.destinationViewController as! ProfileViewController
            
            profileViewController.tweet = tweet
            
            
        }
        else if(segue.identifier == "detailSegue") {
            let cell = sender as! UITableViewCell
            print("push to profilesegue")
            let indexpath = mytableView.indexPathForCell(cell)
            let tweet = tweets[indexpath!.row]
            let detailViewController = segue.destinationViewController as! DetailViewController
            //        detailViewController.hidesBottomBarWhenPushed = true
            detailViewController.tweet = tweet
            
            }
        

    }
    
    
}



