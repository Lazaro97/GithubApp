//
//  NetworkManager.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import Foundation
class NetworkManager {
    
    static let shared = NetworkManager()
    
    let baseURL         = "https://api.github.com/users/"

    private init() {}
    
    //Passing our username and page number and clousure to return an array of followers or error message
    func getFollower(for username: String, page: Int, completed: @escaping([Follower]?, String?) -> Void) {
        
        //Create an endpoint
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        //If there is an error
        guard let url = URL(string: endpoint) else {
            completed(nil,"This username created is an invalid request. Please try again.")
            return
        }
     
        //If there is a valid url and is gonna return data, response and error
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //If there is an internet connection error
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check your internet connection")
                return
            }
            
            //If there is a response url not valid
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            //Making sure is the data nil
            guard let data = data else {
                completed(nil, "The data recieved from the server was invalid.Please try again.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                 completed(nil, "The data is recieved from the server was invalid. Please try again.")
            }
        }
        task.resume()
    }
}
