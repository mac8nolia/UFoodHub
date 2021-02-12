//
//  StringExtensions.swift
//  Ufood
//
//  Created by Ольга on 17.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

extension String {
    
    /**
     Calculates height of the string with specified width and font
     */
    func calculateHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: font],
                                        context: nil)
        return boundingBox.height
    }
}
