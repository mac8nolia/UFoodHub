//
//  UISearchBarExtension.swift
//  Ufood
//
//  Created by Ольга on 29.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    /**
     Sets color for search text field's background
     */
    func setTextField(backgroundColor: UIColor) {
        
        if #available(iOS 13.0, *) {
            searchTextField.backgroundColor = backgroundColor
        } else {
            guard let textfield = value(forKey: "searchField") as? UITextField else { return }
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = backgroundColor
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }
}
