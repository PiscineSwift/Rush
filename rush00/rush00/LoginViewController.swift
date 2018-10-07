//
//  LoginViewController.swift
//  rush00
//
//  Created by Vitalii Poltavets on 10/6/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {

    var network: NetworkService!
    let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=530f5d531a00af2c0ea417d2466d05de77d54688cf48374ae568ae64fd0104c6&redirect_uri=Rush00%3A%2F%2FRush00&response_type=code")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    
}

