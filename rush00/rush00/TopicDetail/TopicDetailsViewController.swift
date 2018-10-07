
//  TopicDetailsViewController.swift
//  rush00
//
//  Created by Vitalii Poltavets on 10/7/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit

class TopicDetailsViewController: UIViewController {

    var topic: Topic!
    private var network: NetworkService!
    var messages: [Message]? {
        willSet {
            DispatchQueue.main.async {
                self.topicTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var topicTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        network = NetworkManager()
        
        network.messages(byTopicId: topic.topicId) { [weak self] messages in
            guard let `self` = self else { return }
            self.messages = messages
        }
        
        
        navigationItem.title = "Topic"
        registerCell()
    }
    
    private func registerCell() {
        var nib = UINib(nibName: "TopicTableViewCell", bundle: Bundle.main)
        topicTableView.register(nib, forCellReuseIdentifier: "TopicTableViewCell")
        nib = UINib(nibName: "MessageTableViewCell", bundle: Bundle.main)
        topicTableView.register(nib, forCellReuseIdentifier: "MessageTableViewCell")
    }
    
    

}


extension TopicDetailsViewController: UITableViewDelegate {
    
    
}


extension TopicDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return messages?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell", for: indexPath) as! TopicTableViewCell
            cell.topicTitle.text = topic.title
            cell.topicText.text = topic.text
            cell.topicAuthor.text = topic.username
            cell.topicTime.text = topic.time
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.messageAuthor.text = messages?[indexPath.row].username
            cell.messageText.text = messages?[indexPath.row].text
            cell.messageTime.text = messages?[indexPath.row].time
            return cell
        }
    }
    
    
    
}
