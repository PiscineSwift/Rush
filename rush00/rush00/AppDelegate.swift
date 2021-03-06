//
//  AppDelegate.swift
//  rush00
//
//  Created by Vitalii Poltavets on 10/5/18.
//  Copyright © 2018 Vitalii Poltavets. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let network = NetworkManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let isLogin = UserDefaults.standard.value(forKey: "isLogin") as? Bool {
            isLogin ? setTopicsRoot() : setLoginRoot()
        }
        
        network.getAccessToken {  [weak self] _, errorMessage in
            if let error = errorMessage { self?.showAlert(withMessage: error) }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        var response = [String: String]()
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        if let queryItems = components.queryItems {
            queryItems.forEach( { response[$0.name] = $0.value } )
        }
        if let code = response["code"] as? String {
            UserDefaults.standard.set(true, forKey: "isLogin") // Set it to false when user logout
            UserDefaults.standard.set(code, forKey: "userToken")
            window?.rootViewController?.dismiss(animated: true, completion: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
            window?.rootViewController = mainViewController
        } else if let error = response["error"] {
            UserDefaults.standard.set(false, forKey: "isLogin") // Just in case
            
            window?.rootViewController?.dismiss(animated: true, completion: nil)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil);
//            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            window?.rootViewController?.present(loginViewController, animated: true, completion: nil)
            
            showAlert(withMessage: error)
        }
        return true
    }
    
    private func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    private func setLoginRoot() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        window?.rootViewController = viewController
    }
    
    private func setTopicsRoot() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        window?.rootViewController = viewController
    }


}

