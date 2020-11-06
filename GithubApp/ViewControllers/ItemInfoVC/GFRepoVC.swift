//
//  GFRepoVc.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/5/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import Foundation
import UIKit

class GFRepoVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        infoItemViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        infoItemViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title:"Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
