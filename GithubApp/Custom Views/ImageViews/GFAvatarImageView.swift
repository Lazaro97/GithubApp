//
//  GFAvatarImageView.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/3/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    
    let cache = NetworkManager.shared.cache
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
    
    
    //Network call for the avatar image for github user
    func downloadImg(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        //Net work call
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else {return}
           
            //Handling error
            guard let data = data else {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            if error != nil {return}
            
            //Good data then we set the image in the cache
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
