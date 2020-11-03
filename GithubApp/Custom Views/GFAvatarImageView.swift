//
//  GFAvatarImageView.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/3/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImg = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImg
        translatesAutoresizingMaskIntoConstraints = false
    }
}
