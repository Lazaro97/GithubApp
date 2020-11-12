    //
//  FollowerListVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit
    
protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false

    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username:String) {
        super.init(nibName:nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
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
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // What ? True : False
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]

        let destinationToUserInfoVC = UserInfoVC()
        destinationToUserInfoVC.username = follower.login
        destinationToUserInfoVC.delegate = self
        
        let navigationController = UINavigationController(rootViewController: destinationToUserInfoVC)
        present(navigationController, animated: true)
    }
    
    //Setting up search bar
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Seach for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    //Network to retrieve the username followers
    //Capture List [weak self]
    func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
        
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
            self.isLoadingMoreFollowers = false
        }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
           NetworkManager.shared.getUserInformation(for: username) { [weak self] result in
               guard let self = self else {return}
               self.dismissLoadingView()
               
               switch result {
               case .success(let user):
               
                   let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                   
                   PersistanceManager.upateWith(favorite: favorite, actionType: .add ) { [weak self] error in
                   guard let self = self else {return}
                   guard let error = error  else {
                   self.presentGFAlertOnMainTread(title: "Success", message: "You have sucessfully favorited this user", buttonTitle: "okay")
                       return
                   }
                       self.presentGFAlertOnMainTread(title: "Something went wrong ", message: error.rawValue, buttonTitle: "Okay")
               }
                   
               
               case .failure(let error):
                   self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Okay")
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
        isSearching = false
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
            guard hasMoreFollowers, !isLoadingMoreFollowers else {return}
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
    
extension FollowerListVC: UISearchResultsUpdating {
        
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            return
    }
        isSearching = true
        //Filter out the array from our search text. $0 represents the array item you are on. We used lowercased becuase it doesement matter if its capitalized or lowercassed.
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
}

    extension FollowerListVC: FollowerListVCDelegate {
        func didRequestFollowers(for username: String) {
            //getFollowers for the user
            
            self.username = username
            title = username
            
            page = 1
            followers.removeAll()
            filteredFollowers.removeAll()
            collectionView.setContentOffset(.zero, animated: true)
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            getFollowers(username: username, page: page)
        }
    }
