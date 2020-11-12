//
//  FollowerCell.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/3/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let resueID = "FollowerCell"
    
    let avatarImg = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
           usernameLabel.text = follower.login
           NetworkManager.shared.downloadImg(from: follower.avatarUrl) { [weak self] image in
               guard let self = self else { return }
               
               DispatchQueue.main.async {
                   self.avatarImg.image = image
               }
           }
        }
        
    
    private func configure() {
        addSubview(avatarImg)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImg.heightAnchor.constraint(equalTo: avatarImg.widthAnchor),
            
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImg.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
}
