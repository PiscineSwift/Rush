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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
