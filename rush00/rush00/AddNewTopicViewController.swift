//
//  AddNewTopicViewController.swift
//  rush00
//
//  Created by Vitalii Poltavets on 10/7/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit

class AddNewTopicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Topic"
        
        request()
    }
    
//    struct Messages_attributes {
//        var author_id: Int
//        var content: String
//    }
//
//    struct Survey_answers_attributes {
//        var name: String
//    }
//
//    struct Survey_attributes {
//        var name: String
//        var survey_answers_attributes: Survey_answers_attributes
//    }
//
//    struct TopicTest {
//        var name: String
//        var kind: String
//        var language_id: String
//        var messages_attributes: Messages_attributes
//        var survey_attributes: Survey_attributes
//    }
    
    private func request() {
        let token = UserDefaults.standard.value(forKey: "access_token") as! String

        let url = "https://api.intra.42.fr/v2/topics.json?access_token=\(token)"
//        let parameterDictionary = TopicTest(name: "test_topic", kind: "normal", language_id: "3",
//                                            messages_attributes: AddNewTopicViewController.Messages_attributes(author_id: 33801, content: "Test"),
//                                            survey_attributes: AddNewTopicViewController.Survey_attributes(name: "TopicName", survey_answers_attributes: AddNewTopicViewController.Survey_answers_attributes(name: "ATTRIBUTES")))

/*        {"topic": {
            "author_id":"94",
            "cursus_ids":["1"],
            "kind":"normal",
            "language_id":"3",
            "messages_attributes":[ {
                "author_id":"21",
                "content":"Hello world",
                "messageable_id":"1",
                "messageable_type":"Topic"
                }
             ],
             "name":"The daily unicorn #837 🦄",
             "tag_ids":["9","7","8"]
             }
         }

*/
        let params = [
            "topic": [
                "name": "testname",
                "kind": "normal",
                "language_id": "3",
                "messages_attributes": [
                    "author_id": 33801,
                    "content": "content"
                ]
            ]
           
        ]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard let `self` = self else { return }
            if error != nil {
                print(error)
//                self.handleError(error! as NSError)
                return
            }
            guard let data = data else { return }
            let dictinary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any?]
            print(dictinary)
//            self.convertResponse(response: dictinary)
        }).resume()
        
    }
}
