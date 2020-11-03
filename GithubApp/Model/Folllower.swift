//
//  Folllower.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import Foundation

struct Follower: Codable {
    var login: String
    //This dosent work in swift becuase of the underscore.
    ///var avatar_url: String
    var avatarUrl: String
    
}
