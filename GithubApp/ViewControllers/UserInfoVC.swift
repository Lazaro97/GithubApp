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
        
        NetworkManager.shared.getUserInformation(for: username) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
                print(user)
                
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "okay")
            }
        }
    }
    
    @objc func dismissVCView() {
        dismiss(animated: true)
    }
}
