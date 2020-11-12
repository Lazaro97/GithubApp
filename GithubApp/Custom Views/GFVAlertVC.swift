//
//  GFVAlertVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class GFVAlertVC: UIViewController {

    let errorView = UIView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Okay")

    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureAlertView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
  
    
    func configureAlertView() {
        view.addSubview(errorView)
        errorView.backgroundColor = .systemBackground
        errorView.layer.cornerRadius = 16
        errorView.layer.borderWidth = 2
        errorView.layer.borderColor = UIColor.white.cgColor
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.widthAnchor.constraint(equalToConstant: 280),
            errorView.heightAnchor.constraint(equalToConstant: 220)
            ])
    }
    
    func configureTitleLabel(){
        errorView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        errorView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Okay", for: .normal)
        actionButton.addTarget(self, action: #selector(dimissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            ,])
    }
    
    @objc func dimissVC(){
        dismiss(animated: true)
    }

    func configureMessageLabel() {
        errorView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
            
            ,])
    }
}

