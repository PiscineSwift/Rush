//
//  topicViewCell.swift
//  rush00
//
//  Created by Yevheniia ZAVHORODNIA on 07.10.2018.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit

class topicViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var topicTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cellContainer: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cellContainer.layer.cornerRadius = 5
         selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
