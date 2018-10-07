//
//  MainPageViewController.swift
//  rush00
//
//  Created by Yevheniia ZAVHORODNIA on 07.10.2018.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit
import Foundation

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topicsTableView: UITableView!
    
    var topics : [Topic] = [] {
        willSet {
            DispatchQueue.main.async {
                self.topicsTableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! topicViewCell
        
        cell.usernameLabel.text = topics[indexPath.row].username
        cell.timeLabel.text = topics[indexPath.row].time
        cell.topicTextLabel.text = topics[indexPath.row].title
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTopics()
        
        navigationItem.title = "Forum"
    }
    
    func loadTopics() {
        print("here")
        let token = UserDefaults.standard.value(forKey: "access_token") as! String
        let url = "https://api.intra.42.fr/v2/topics.json?access_token=\(token)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
//        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard let `self` = self else { return }
            if error != nil {
                self.handleError(error! as NSError)
                return
            }
            guard let data = data else { return }
            let dictinary = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any?]]
            print(dictinary)
            self.convertResponse(response: dictinary)
            
//            if let statuses = response.value(forKey: "statuses") as? [[String: Any]] {
//                self.convertResponse(response: statuses)
//            } else {
//                guard let error = error else { return }
//                self.handleError(error as NSError)
//            }
        }).resume()
        
    }
    
    func convertResponse(response statuses: [[String: Any]]) {
        print("here2")
        for status in statuses {
            if let author = status["author"] as? [String: Any] {
                if let message = status["message"] as? [String: Any] {
                    if let content = message["content"] as? [String: Any] {
                        let topic = Topic(topicId: status["id"] as! Int, usrId: author["id"] as! Int, username: author["login"] as! String, title: status["name"] as! String, text: content["markdown"] as! String, time: status["created_at"] as! String)
                        topics.append(topic)
                    }
                }
            }
        }
    }
    
    func handleError(_ error: NSError) {
        print("Error while getting topics")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addNewTopic(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddNewTopicViewController", sender: self)
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        present(loginViewController, animated: true, completion: nil)
        UIApplication.shared.windows[0].rootViewController = loginViewController
    }
    
}
//private func convertResponse(response statuses: [[String: Any]]) -> [Tweet] {
//    var tweets: [Tweet] = []
//    for status in statuses {
//        if let user = status["user"] as? [String: Any] {
//            let tweet = Tweet(name: user["name"] as! String, text: status["text"] as! String, time: status["created_at"] as! String)
//            tweets.append(tweet)
//        }
//    }
//    return tweets
//}

//private func request(with query: String, count: Int = 100) {
//    let stringURL = "https://api.twitter.com/1.1/search/tweets.json?"
//    let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//    let url = stringURL + "q=\(encodedQuery)&lang=en&count=\(count)"
//    var request = URLRequest(url: URL(string: url)!)
//    request.httpMethod = "GET"
//    request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//    URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
//        guard let `self` = self else { return }
//        if error != nil {
//            self.delegate?.handleError(error! as NSError)
//            return
//        }
//        guard let data = data else { return }
//        let response = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//        if let statuses = response.value(forKey: "statuses") as? [[String: Any]] {
//            let tweets = self.convertResponse(response: statuses)
//            self.delegate?.processTweets(tweets)
//        } else {
//            guard let error = error else { return }
//            self.delegate?.handleError(error as NSError)
//        }
//    }).resume()

