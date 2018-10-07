//
//  Model.swift
//  rush00
//
//  Created by Yevheniia ZAVHORODNIA on 07.10.2018.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import Foundation

struct Topic {
    let usrId : Int
    let username : String
    let text : String
    let time : String
}

struct Message {
    let usrId : Int
    let username : String
    let text : String
    let time : String
//    let replies : [Message]?
//    let isReply : Bool
}
