//
//  CALayerExtensions.swift
//  Ufood
//
//  Created by Ольга on 30.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import QuartzCore
import UIKit

extension CALayer {
    
    /**
     Adds shadow with design parameters to layer
     */
    func applyDesignShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
