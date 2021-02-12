//
//  Fonts.swift
//  Ufood
//
//  Created by Ольга on 12.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

struct AppFont {
    
    /**
     Returns medium font for specified size
     */
    static func defaultMediumFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
    
    /**
     Returns regular font for specified size
     */
    static func defaultRegularFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
    
    /**
     Returns bold font for specified size
     */
    static func defaultBoldFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
    }
}
