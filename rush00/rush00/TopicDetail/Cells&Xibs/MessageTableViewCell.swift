//
//  MessageTableViewCell.swift
//  rush00
//
//  Created by Vitalii Poltavets on 10/7/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var topicAuthor: UILabel!
    @IBOutlet weak var topicTime: UILabel!
    @IBOutlet weak var topicText: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 5
         selectionStyle = .none
    }

    
}
