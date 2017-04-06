//
//  RepoCellTableViewCell.swift
//  GithubDemo
//
//  Created by Mendoza, Alejandro on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class RepoCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorCell: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
