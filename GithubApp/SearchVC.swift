//
//  SearchVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 10/24/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    ///This set up our UI Outlets
    let logoImg             = UIImageView()
    let usernameTextField   = GFTextField()
    let callToActionBtn     = GFButton(backgroundColor: .systemGreen, title: "Get followers")


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImg()
        configureTextField()
        configureCallToActionButton()
    }
    
    ///Hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    func configureLogoImg() {
        ///Grabbing a UIImageView from libary and dragging to the view controller.
        view.addSubview(logoImg)
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        logoImg.image = UIImage(named: "gh-logo")!
    
    /// Adding constraints
    NSLayoutConstraint.activate([
        logoImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
        logoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        logoImg.heightAnchor.constraint(equalToConstant: 200),
        logoImg.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant:  48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionBtn)

        NSLayoutConstraint.activate([
            callToActionBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:  -50),
            callToActionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionBtn.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
