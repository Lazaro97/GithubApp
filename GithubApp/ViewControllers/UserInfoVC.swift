//
//  UserInfoVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/4/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVCView))
        navigationItem.rightBarButtonItem = doneBtn
        print(username!)
        
    }
    
    @objc func dismissVCView() {
        dismiss(animated: true)
    }
}
