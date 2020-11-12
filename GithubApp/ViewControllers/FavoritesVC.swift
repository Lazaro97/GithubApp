//
//  FavoritesVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 10/24/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    let tableView = UITableView()
    
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.resuseID)
        
        //Fill up the screen.
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func getFavorites(){
    PersistanceManager.retrieveFavorites{ [weak self]result in
        guard let self = self else {return}
        
        switch result {
                   case .success(let favorites):
                    if favorites.isEmpty {
                        self.showEmptyStateView(with: "No Favorites", in: self.view)
                    } else {
                        self.favorites = favorites
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.view.bringSubviewToFront(self.tableView)
                        }
                    }
                   case .failure(let error):
                    self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
                   }
               }
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.resuseID) as! FavoriteCell
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationVC = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.upateWith(favorite: favorite, actionType: .remove) { [weak self] (error) in
            guard let self = self else {return}
            
            guard let error = error else {return}
            self.presentGFAlertOnMainTread(title: "Unable to remove ", message: error.rawValue, buttonTitle: "Okay")
        }
    }
}
