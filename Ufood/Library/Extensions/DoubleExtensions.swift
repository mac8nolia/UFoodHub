//
//  DoubleExtensions.swift
//  Ufood
//
//  Created by Ольга on 20.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

extension Double {
    
    /**
     Rounds the double to decimal places value
     */
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

