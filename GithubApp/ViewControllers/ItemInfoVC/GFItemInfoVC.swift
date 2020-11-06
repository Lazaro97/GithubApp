//
//  GFItemInfoVCViewController.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/5/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let stackView = UIStackView()
    let infoItemViewOne = GFItemInfoVIew()
    let infoItemViewTwo = GFItemInfoVIew()
    let actionButton = GFButton()
    
    var user: User!
    
    //For button pressed 
    weak var delegate: UserInfoVCDelegate!
    
    init(user: User) {
           super.init(nibName: nil, bundle: nil)
           self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    //Stackview
    private func configureStackView() {
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(infoItemViewOne)
        stackView.addArrangedSubview(infoItemViewTwo)
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {
        
    }
    //StackView Constraints and button 
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
