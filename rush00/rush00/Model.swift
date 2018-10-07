//
//  Model.swift
//  rush00
//
//  Created by Yevheniia ZAVHORODNIA on 07.10.2018.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import Foundation

struct Topic {
    let topicId : Int
    let usrId : Int
    let username : String
    let title : String
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

//yzavhoro [2:09 PM]
//    {
//    "id": 19537,
//    "name": "test_topic",
//    "author": {
    //    "id": 33801,
    //    "login": "yzavhoro",
    //    "url": "https://api.intra.42.fr/v2/users/yzavhoro"
//    },
//    "kind": "normal",
//    "created_at": "2018-10-07T11:03:54.984Z",
//    "updated_at": "2018-10-07T11:03:55.158Z",
//    "pinned_at": null,
//    "locked_at": null,
//    "pinner": null,
//    "locker": null,
//    "language": {
    //    "id": 2,
    //    "name": "English",
    //    "identifier": "en"
//    },
//    "messages_url": "https://api.intra.42.fr/v2/topics/19537/messages",
//    "message": {
    //    "id": 95751,
    //    "content": {
        //    "markdown": "start message",
        //    "html": "<p>start message</p>"
    //    }
//    },

