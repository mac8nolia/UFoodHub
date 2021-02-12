//
//  UIViewControllerExtension.swift
//  Ufood
//
//  Created by Ольга on 21.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

extension UITableViewController{
    
    /**
     Sets visual configures for the navigation bar
     */
    func configureNavigationBar(backgroundColor: UIColor?, tintColor: UIColor, title: String, translucent: Bool, hideBorderLine: Bool) {
        
        // Set common for all versions configures
        navigationItem.title = title
        navigationController?.navigationBar.isTranslucent = translucent
        navigationController?.navigationBar.tintColor = tintColor
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: tintColor]
            navBarAppearance.backgroundColor = backgroundColor
            
            if translucent {
                navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationController!.navigationBar.shadowImage = UIImage()
            } else {
                navigationController!.navigationBar.setBackgroundImage(nil, for: .default)
                navigationController!.navigationBar.shadowImage = nil
            }
            
            if hideBorderLine {
                navBarAppearance.shadowColor = .clear
            }
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        } else {
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.barTintColor = backgroundColor
            
            if hideBorderLine {
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.layoutIfNeeded()
            } else {
                self.navigationController?.navigationBar.setBackgroundImage(nil, for:.default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.layoutIfNeeded()
            }
        }
    }
}
