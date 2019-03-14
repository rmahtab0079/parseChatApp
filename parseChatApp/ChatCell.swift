//
//  ChatCell.swift
//  parseChatApp
//
//  Created by Rageeb Mahtab on 3/14/19.
//  Copyright © 2019 Rageeb Mahtab. All rights reserved.
//

import UIKit
import Parse

class ChatCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
