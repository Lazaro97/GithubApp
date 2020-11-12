//
//  GFEmptyStateView.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/4/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLbl = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     convenience init(message:String) {
        self.init(frame: .zero)
        messageLbl.text = message
    }
    
    private func configure() {
    configureMessageLabel()
       configureLogoImageView()
    }
    
    private func configureMessageLabel() {
        addSubview(messageLbl)
        messageLbl.numberOfLines = 3
        messageLbl.textColor = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        let messageLabelCenterYConstraint = messageLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant:labelCenterYConstant)
        messageLabelCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            ///messageLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLbl.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(named: "empty-state-logo")!
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstnat: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        let logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstnat)
        logoImageViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            /// logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
