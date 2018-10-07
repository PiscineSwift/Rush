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
    
    let token : String = "242442282ba3cb892a4e604db5a993d94a8c949fdbd136f8f92e9b4736396cc5"
    var topics : [Topic] = [] {
        willSet {
            self.topicsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! topicViewCell
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTopics()
    }
    
    func loadTopics() {
//        let url = "https://api.intra.42.fr/v2/topics.json?access_token=" + token
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "GET"
//        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
//            guard let `self` = self else { return }
//            if error != nil {
//                self.handleError(error! as NSError)
//                return
//            }
//            guard let data = data
//        }).resume()
//
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
