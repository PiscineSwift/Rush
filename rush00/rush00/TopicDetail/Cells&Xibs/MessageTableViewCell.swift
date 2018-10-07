//
//  MessageTableViewCell.swift
//  rush00
//
//  Created by Vitalii Poltavets on 10/7/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageAuthor: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
