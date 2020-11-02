//
//  ViewControllerExtensions.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/2/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainTread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = GFVAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC,animated: true)
        }
    }
}
