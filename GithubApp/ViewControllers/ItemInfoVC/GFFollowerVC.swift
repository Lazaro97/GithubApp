//
//  GFFollowerVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/5/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import Foundation

import UIKit

class GFFollowerVC : GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        infoItemViewOne.set(itemInfoType: .
            followers, withCount: user.followers)
        infoItemViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
