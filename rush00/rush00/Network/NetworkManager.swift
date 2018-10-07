//
//  NetworkManager.swift
//  rush00
//
//  Created by Vitalii Poltavets on 10/6/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import Foundation

protocol NetworkService {
    
    func getAccessToken(_ completion: @escaping (_ accessToken: String?, _ errorMessage: String?) -> Void)
    func messages(byTopicId topicId: Int, completion: @escaping ([Message]) -> Void)
}

final class NetworkManager: NetworkService {
    
    private let uid = "530f5d531a00af2c0ea417d2466d05de77d54688cf48374ae568ae64fd0104c6"
    private let secret = "555f8f46a94c2a1ae7dc49003a338484f429ab0a52727d55c20e63a095eed523"
    private let stringURL = "https://api.intra.42.fr/oauth/token"
    
    func getAccessToken(_ completion: @escaping (_ accessToken: String?, _ errorMessage: String?) -> Void) {
        let encodedData = (uid + ":" + secret).data(using: String.Encoding.utf8)
        let bearer = encodedData!.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
        guard let url = URL(string: stringURL) else { print("Wrong URL"); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
            }
            if let data = data {
                if let dictinary = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any?] {
                    guard let token = dictinary["access_token"] as? String else { return }
                    UserDefaults.standard.set(token, forKey: "access_token")
                    completion(token, nil)
                } else {
                    completion(nil, "Error while decode data")
                }
            }
        }
        task.resume()
    }
    
    func messages(byTopicId topicId: Int, completion: @escaping ([Message]) -> Void) {
        let token = UserDefaults.standard.value(forKey: "access_token") as! String
        let url = "https://api.intra.42.fr/v2/topics/\(topicId)/messages?access_token=\(token)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            if error != nil {
                print(error)
            }
            guard let data = data else { return }
            let responseData = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any?]?]
            var messages: [Message] = []
            for messageContainer in responseData {
                if let messageContainer = messageContainer as? [String: Any] {
                    if let author = messageContainer["author"] as? [String: Any] {
                        if let content = messageContainer["content"] as? String {
                            if let time = messageContainer["created_at"] as? String {
                                let formattedTime = time.components(separatedBy: "T")
                                let message = Message(usrId: author["id"] as! Int, username: author["login"] as! String, text: content, time: formattedTime[0])
                                messages.append(message)
                            }
                        }
                    }
                }
            }
            completion(messages)
        }.resume()
    }
    
    
    
}
