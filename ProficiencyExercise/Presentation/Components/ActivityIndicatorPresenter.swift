//
//  ActivityIndicatorPresenter.swift
//  ProficiencyExercise
//
//  Created by Jeni on 20/07/20.
//  Copyright © 2020 Jeni. All rights reserved.
//

import Foundation
import UIKit

public protocol ActivityIndicatorPresenter {
    
    var activityIndicator: UIActivityIndicatorView { get }
    func showActivityIndicator()
    func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            
            if #available(iOS 13.0, *) {
                self.activityIndicator.style = .large
            } else {
                self.activityIndicator.style = .gray
            }
            self.activityIndicator.color = .darkGray
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80) //or whatever size you would like
            self.activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
