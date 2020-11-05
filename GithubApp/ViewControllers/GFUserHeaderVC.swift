//
//  GFUserHeaderVC.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/5/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class GFUserHeaderVC: UIViewController {

    let userAvatarImg = GFAvatarImageView(frame: .zero)
    let usernameLbl = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLbl = GFSecoundaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationNameLbl = GFSecoundaryTitleLabel(fontSize: 18)
    let userBioLbl = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        layoutHeaderUI()
        configureUIElements()
    }
    
    func configureUIElements(){
        userAvatarImg.downloadImg(from: user.avatarUrl)
        usernameLbl.text = user.login
        nameLbl.text = user.name ?? "N/A"
        locationNameLbl.text = user.location ?? "N/A"
        userBioLbl.text = user.bio ?? "No bio avilable"
        userBioLbl.numberOfLines = 3
        
        //We created a constant for our systemName String
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func addSubView() {
        view.addSubview(userAvatarImg)
        view.addSubview(usernameLbl)
        view.addSubview(nameLbl)
        view.addSubview(locationImageView)
        view.addSubview(locationNameLbl)
        view.addSubview(userBioLbl)
    }
    
    
    func layoutHeaderUI(){
        let padding:CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userAvatarImg.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            userAvatarImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userAvatarImg.widthAnchor.constraint(equalToConstant: 90),
            userAvatarImg.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLbl.topAnchor.constraint(equalTo: userAvatarImg.topAnchor),
            usernameLbl.leadingAnchor.constraint(equalTo: userAvatarImg.trailingAnchor, constant: textImagePadding),
            usernameLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLbl.heightAnchor.constraint(equalToConstant: 38),
            
            
            nameLbl.centerYAnchor.constraint(equalTo: userAvatarImg.centerYAnchor, constant: 8),
            nameLbl.leadingAnchor.constraint(equalTo: userAvatarImg.trailingAnchor, constant: textImagePadding),
            nameLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLbl.heightAnchor.constraint(equalToConstant: 20),
            
            
            locationImageView.bottomAnchor.constraint(equalTo: userAvatarImg.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: userAvatarImg.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationNameLbl.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationNameLbl.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationNameLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationNameLbl.heightAnchor.constraint(equalToConstant: 60),
            
            userBioLbl.topAnchor.constraint(equalTo: userAvatarImg.bottomAnchor, constant: textImagePadding),
            userBioLbl.leadingAnchor.constraint(equalTo: userAvatarImg.leadingAnchor),
            userBioLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userBioLbl.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
