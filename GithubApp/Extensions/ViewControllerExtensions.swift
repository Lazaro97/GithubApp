//
//  ViewControllerExtensions.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

//We use Fileprivate becuase extensions cant hold variable so we use now use varibles
fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainTread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFVAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC,animated: true)
        }
    }

    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        //alpha means transparency
        containerView.alpha = 0
        
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicatior = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicatior)
        activityIndicatior.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatior.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatior.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicatior.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView){
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
