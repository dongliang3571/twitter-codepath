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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mytableView.delegate = self
        mytableView.dataSource = self
        
        
        TwitterClient.shareInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.mytableView.reloadData()

            for t in tweets {
                print("\(t.profileImage)")
            }
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
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

}


extension TweetsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        
//        if let imgUrl = tweets[indexPath.row].profileImage {
//            
//            cell.profileImage.setImageWithURL(imgUrl)
//        }
        
//        cell.tweetText.text =  tweets[1].text as! String
//        let hhaa = tweets[1].text
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets  {
            return tweets.count
        } else {
            return 0
        }
        
    }
    
}
