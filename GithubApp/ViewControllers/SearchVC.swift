//
//  SearchVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 10/24/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    //This set up our UI Outlets
    let logoImg             = UIImageView()
    let usernameTextField   = GFTextField()
    let callToActionBtn     = GFButton(backgroundColor: .systemGreen, title: "Get followers")

    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createDismissKeyboardTapGesture()
        configureLogoImg()
        configureTextField()
        configureCallToActionButton()
    }
    
    //Hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func createDismissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func segueToFollowerListVC() {
        
        //If there is no username then else action appears for text validation
        guard isUsernameEntered else {
            presentGFAlertOnMainTread(title: "Empty Username", message: "Please enter a username.We need to know who to look for.", buttonTitle: "Okay")
            return
        }
        
        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        
        //Push it to our navigation
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImg() {
    //Grabbing a UIImageView from libary and dragging to the view controller.
        view.addSubview(logoImg)
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        logoImg.image = UIImage(named: "gh-logo")!
    
    //Adding constraints
    NSLayoutConstraint.activate([
        logoImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
        logoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        logoImg.heightAnchor.constraint(equalToConstant: 200),
        logoImg.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        //Delegate for our textfield when a user press done
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant:  48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionBtn)
        //Get followers func is being called when user press button
        callToActionBtn.addTarget(self, action: #selector(segueToFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:  -50),
            callToActionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionBtn.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}


//Delegate for return key is pressed
extension SearchVC: UITextFieldDelegate {
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        segueToFollowerListVC()
        return true
    }
}
