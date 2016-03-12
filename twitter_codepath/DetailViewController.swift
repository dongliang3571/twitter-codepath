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


    
    var tweet: Tweet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailTableView.dataSource = self
        DetailTableView.delegate = self
        DetailTableView.rowHeight = UITableViewAutomaticDimension
        DetailTableView.estimatedRowHeight = 120
        DetailTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if let tweet = tweet {
            
            print("table is prepared to set")
            DetailTableView.reloadData()
            print("prepared is finished")
        }
        // Do any additional setup after loading the view.
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
            return cell
        }
        
        else if indexPath.row == 1 {
            let cell = DetailTableView.dequeueReusableCellWithIdentifier("RetweetCell", forIndexPath:
                indexPath) as! RetweetTableViewCell
            cell.retweet.text = "\((self.tweet?.retweetCount)!)"
            cell.favorites.text = "\((self.tweet?.favoriteCount)!)"
            print(tweet?.favoriteCount)
            return cell
        }
        
        else if indexPath.row == 2 {
            let cell = DetailTableView.dequeueReusableCellWithIdentifier("ReplyCell", forIndexPath:
                indexPath) as! ReplyTableViewCell
            
            cell.isFavorited = tweet?.isFavorited
            cell.tweetID = tweet?.tweetID
            
            print(cell.tweetID)
            print(cell.isFavorited)
            
            
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
}
