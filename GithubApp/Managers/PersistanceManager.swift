//
//  PersistanceManager.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/6/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}


enum PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func upateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping(GFError?) -> Void ) {
        retrieveFavorites { result in
            switch result {
            case.success(let favorites):
                var retrieveFavorties = favorites
                
                switch actionType {
                case .add:
                    guard !retrieveFavorties.contains(favorite) else {
                        completed(.alreadyInFavorites)
                    return
                }
                    
                retrieveFavorties.append(favorite)
               
                case .remove:
                    retrieveFavorties.removeAll { $0.login == favorite.login}
                }
                
                completed(save(favorites: retrieveFavorties))
                
            case.failure(let error) :
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>)-> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFav))
        }
    }

static func save(favorites: [Follower]) -> GFError? {
    do {
        let encoder = JSONEncoder()
        let encodedFavorites = try encoder.encode(favorites)
        defaults.set(encodedFavorites, forKey: Keys.favorites)
        return nil
    }
    catch {
        return .unableToFav
        }
    }
}
