//
//  TweetViewController.swift
//  twitter_codepath
//
//  Created by dong liang on 3/11/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class TweetViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers![0].tabBarItem.title = "Home"
        self.viewControllers![0].tabBarItem.image = UIImage(named: "home")
        
        self.viewControllers![1].tabBarItem.title = "Me"
        self.viewControllers![1].tabBarItem.image = UIImage(named: "me")
        
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
