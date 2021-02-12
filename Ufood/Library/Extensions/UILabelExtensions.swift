//
//  UILabelExtensions.swift
//  Ufood
//
//  Created by Ольга on 20.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import UIKit

extension UILabel {

    /**
     Picks appropriate font size for multiline label.
     Parameters:
         - array with different variations of pairs of font's size and number of lines of label (must be descending);
         - width of label;
         - font of label.
     Returns: font's size.
     */
    func pickFontSizeFrom(array: [(fontSize: CGFloat, numberOfLines: Int)], forWidth width: CGFloat, andFont font: UIFont) -> CGFloat {
        
        if array.count == 0 {
            // Return current font's size:
            return font.pointSize
            
        } else if array.count == 1 {
            // Return single size from array:
            return array[0].fontSize
            
        } else {
            guard let text = self.text else { return font.pointSize }
            for i in 0..<(array.count - 1) {
                // Create font with size from array
                let newFont = font.withSize(array[i].fontSize)
                // Calculate number of lines with this font
                let calcNumberOfString = text.calculateHeight(width: width, font: newFont)/newFont.lineHeight
                let roundedCalcNumber = Int(calcNumberOfString.rounded(.toNearestOrAwayFromZero))
                // If calculated number of lines equal to number from array (corresponding to current size) - return this size
                if roundedCalcNumber == array[i].numberOfLines {
                    return array[i].fontSize
                }
            }
            // Else return last size as minimum by default
            return array.last!.fontSize
        }
    }
}
