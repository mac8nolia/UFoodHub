//
//  UIButtonExtension.swift
//  Ufood
//
//  Created by Ольга on 27.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     Adds animation after button's tap and executes completion block
     */
    func pressAnimation(completion: ((Bool) -> Void)?) {
        
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.3,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.20),
                                   initialSpringVelocity: CGFloat(6.0),
                                   options: UIView.AnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.transform = CGAffineTransform.identity
                                   },
                                   completion: completion
        )
    }
}


