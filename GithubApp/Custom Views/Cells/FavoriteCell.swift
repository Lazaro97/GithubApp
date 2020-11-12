
//
//  FavoriteCell.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/12/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let resuseID = "FavoritesCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLbl = GFTitleLabel(textAlignment: .center, fontSize: 16)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     func set(favorite: Follower){
         usernameLbl.text = favorite.login
         avatarImageView.downloadImg(from: favorite.avatarUrl)
     }
     
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLbl)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
           
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
        
            
            usernameLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLbl.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLbl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
