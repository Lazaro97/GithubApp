//
//  GFEmptyStateView.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/4/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLbl = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message:String) {
        super.init(frame: .zero)
        messageLbl.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLbl)
        addSubview(logoImageView)
        
        messageLbl.numberOfLines = 3
        messageLbl.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")!
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLbl.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
            
            
        ])
    }
}
