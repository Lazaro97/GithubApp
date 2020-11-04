    //
//  FollowerListVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var page = 1
    var hasMoreFollowers = true

    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resueID)
    }
    
    //This is where we adjust the cell layout. In this case we wanted a collection view of three columns
    func createThreeColumFlowLayout() -> UICollectionViewFlowLayout {
        
        let width               = view.bounds.width
        let padding: CGFloat    = 12
        let minimumItemSpacing : CGFloat = 10
        let avilableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = avilableWidth / 3
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowlayout
    }
   
    //Setting up search bar
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Seach for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    //Network to retrieve the username followers
    //Capture List [weak self]
    func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollower(for: username, page: page) { [weak self] result in
        
        guard let self = self else {return}
        
        self.dismissLoadingView()

        switch result {
            case .success(let followers):
            if followers.count < 100 {
                self.hasMoreFollowers = false
            }
            self.followers.append(contentsOf: followers)
            
            if self.followers.isEmpty {
                let message = "This user does not have any followers. Go follow them"
                DispatchQueue.main.async {
                    self.showEmptyStateView(with: message, in: self.view)
                    return
                }
            }
            self.updateData(on: self.followers)

            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Bad stuff happend", message: error.rawValue, buttonTitle: "Okay")
            }
        }
    }
    
    //This is where we configure the cell with data
    func configureDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {
        (collectionView, IndexPath, follower) -> UICollectionViewCell? in
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resueID, for: IndexPath) as! FollowerCell
            
        cell.set(follower:follower)
            
        return cell
        })
    }
    
    //Here we update data
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.datasource.apply(snapshot, animatingDifferences:  true)
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
    
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
        
    func updateSearchResults(for searchController: UISearchController) {
            guard let filter = searchController.searchBar.text, !filter.isEmpty else {
                return
            }
        //Filter out the array from our search text. $0 represents the array item you are on. We used lowercased becuase it doesement matter if its capitalized or lowercassed.
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
  }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       updateData(on: followers)
    }
}
