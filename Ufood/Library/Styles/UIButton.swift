//
//  UIButton.swift
//  Ufood
//
//  Created by Ольга on 20.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     Action button with given title and color
     */
    func styleActionWith(title: String, color: UIColor) {
        backgroundColor = color
        setTitle(title, for: .normal)
        titleLabel?.font =  AppFont.defaultBoldFont(size: 17)
        roundCorners(corners: [.bottomLeft, .bottomRight, .topLeft, .topRight], radius: 7)
    }
}
