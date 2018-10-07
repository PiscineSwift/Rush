//
//  MainPageViewController.swift
//  rush00
//
//  Created by Yevheniia ZAVHORODNIA on 07.10.2018.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit
import Foundation

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var topicsTableView: UITableView!
    
    var currentRow: Int!
    
    var topics : [Topic] = [] {
        willSet {
            DispatchQueue.main.async {
                self.topicsTableView.reloadData()
            }
            
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "TopicDetailsViewController") {
            if let vc = segue.destination as? TopicDetailsViewController {
                print(topics[currentRow])
                vc.topic = topics[currentRow]
            }
        }
    }
}

extension MainPageViewController: UITableViewDelegate {
    
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
    
}

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        performSegue(withIdentifier: "TopicDetailsViewController", sender: self)
    }
    
}
