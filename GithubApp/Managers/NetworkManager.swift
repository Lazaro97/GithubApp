//
//  NetworkManager.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//


import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    
    let cache = NSCache<NSString, UIImage>()

    private init() {}
    
    //Passing our username and page number and clousure to return an array of followers or error message
    ///We used GFError from GFError strcut enum function
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GFError>) -> Void) {
        
        //Create an endpoint
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        //If there is an error
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
     
        //If there is a valid url and is gonna return data, response and error
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //If there is an internet connection error
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            //If there is a response url not valid
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            //Making sure is the data nil
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getUserInformation(for username: String, completed: @escaping(Result<User, GFError>) -> Void) {
           
           //Create an endpoint
           let endpoint = baseURL + "\(username)"
           
           //If there is an error
           guard let url = URL(string: endpoint) else {
               completed(.failure(.invalidUsername))
               return
           }
        
           //If there is a valid url and is gonna return data, response and error
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               
               //If there is an internet connection error
               if let _ = error {
                   completed(.failure(.unableToComplete))
                   return
               }
               
               //If there is a response url not valid
               guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                   completed(.failure(.invalidResponse))
                   return
               }
               
               //Making sure is the data nil
               guard let data = data else {
                   completed(.failure(.invalidData))
                   return
               }
               
               do {
                   let decoder = JSONDecoder()
                   decoder.keyDecodingStrategy = .convertFromSnakeCase
                   let user = try decoder.decode(User.self, from: data)
                   completed(.success(user))
               } catch {
                   completed(.failure(.invalidData))
               }
           }
           task.resume()
    }
}
