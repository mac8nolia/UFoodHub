//
//  UILabel.swift
//  Ufood
//
//  Created by Ольга on 20.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     Centered label with medium-size font
     */
    func styleMediumCenterWith(text: String) {
        self.text = text
        font = AppFont.defaultMediumFont(size: 20)        
        textAlignment = .center
    }
    
    /**
     Centered label with regular-size font
     */
    func styleRegularCenterWith(text: String) {
        self.text = text
        font = AppFont.defaultRegularFont(size: 17)
        textAlignment = .center
    }
    
    /**
     Lefted multiline label with regular-size font (for cell's names)
     */
    func styleCellName() {
        font = AppFont.defaultRegularFont(size: 17)
        textAlignment = .left
        numberOfLines = 0
    }
    
    /**
     Centered gray label with small-size font, could be shrink (for cell's values)
     */
    func styleCellValue() {
        font = AppFont.defaultRegularFont(size: 15)
        textAlignment = .center
        textColor = .darkGray
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
}
