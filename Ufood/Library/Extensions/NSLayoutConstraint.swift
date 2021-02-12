//
//  NSLayoutConstraint.swift
//  Ufood
//
//  Created by Ольга on 23.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    /**
     Changes constraint's multiplier
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}
