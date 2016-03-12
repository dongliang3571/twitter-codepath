//
//  RetweetTableViewCell.swift
//  twitter_codepath
//
//  Created by dong liang on 3/12/16.
//  Copyright © 2016 dong. All rights reserved.
//

import UIKit

class RetweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var retweet: UILabel!
    
    @IBOutlet weak var favorites: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
