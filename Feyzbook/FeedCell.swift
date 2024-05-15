//
//  FeedCell.swift
//  Feyzbook
//
//  Created by Feyzullah Durası on 15.05.2024.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var postImageview: UIImageView!
    @IBOutlet weak var emailText: UILabel!
    
    @IBOutlet weak var yorumText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
