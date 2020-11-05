//
//  UserInfoVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/4/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(username!)
        configureViewController()
        layoutUI()
        getGithubUserInfomarion()
    }
    
   func getGithubUserInfomarion() {
          NetworkManager.shared.getUserInformation(for: username) { [weak self] result in
                     guard let self = self else {return}
                     
                     switch result {
                     case .success(let user):
                     //Here we add the headerVC
                         DispatchQueue.main.async {
                         self.add(childVC:    GFUserHeaderVC(user: user), to: self.headerView)
                            self.add(childVC: GFRepoVC(user: user), to: self.itemViewOne)
                            self.add(childVC: GFFollowerVC(user: user), to: self.itemViewTwo)
                            self.dateLabel.text = "Github Since \(user.createdAt.convertToDispalyFormat())"

                         }
                     case .failure(let error):
                         self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "okay")
                     }
                 }
      }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVCView))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    
    @objc func dismissVCView() {
        dismiss(animated: true)
    }
    
    
    func layoutUI() {
        
        ///Header View
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        ///ItemViewOne
        view.addSubview(itemViewOne)
        itemViewOne.backgroundColor = .systemPink

        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140)
            ,])
        
        ///ItemViewTwo
        view.addSubview(itemViewTwo)
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.backgroundColor = .systemPink


        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140)
        ,])
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: 18 )
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
}
