//
//  FollowerListVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
   
    var username: String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resueID)
    }
    
    func createThreeColumFlowLayout() -> UICollectionViewFlowLayout {
        let width               = view.bounds.width
        let padding: CGFloat    = 12
        let minimumItemSpacing : CGFloat = 10
        let avilableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = avilableWidth / 3
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return UICollectionViewFlowLayout()
    }
    
    
    func getFollowers() {
        NetworkManager.shared.getFollower(for: username, page: 1) { result in
        
        switch result {
            case .success(let followers):
                print(followers)

            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
}
