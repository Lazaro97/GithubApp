//
//  FollowerListVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollower(for: username, page: 1) { (followers, errormessage) in
            guard let followers = followers else {
                self.presentGFAlertOnMainTread(title: "Bad stuff happend", message: errormessage!, buttonTitle: "Okay")
                return
            }
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }
}
