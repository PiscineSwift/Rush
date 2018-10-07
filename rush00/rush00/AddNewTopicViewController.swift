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
    
    private func request() {
        let token = UserDefaults.standard.value(forKey: "access_token") as! String

        let url = "https://api.intra.42.fr/v2/topics.json"//?access_token=\(token)"

        let params = ["topic": ["author_id":"33801", "cursus_ids":["1"], "kind":"normal", "language_id":["13"], "messages_attributes":[["author_id":"33801","content":"content......."]], "name":"test", "tag_ids":["7"]]]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
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
        }).resume()
        
    }
}
