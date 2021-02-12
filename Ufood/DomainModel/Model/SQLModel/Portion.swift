//
//  Portion.swift
//  Ufood
//
//  Created by Ольга on 19.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

class Portion: NSObject {
    
    /**
     Name of portion for represence
     */
    let name: String
    
    /**
     Weight of portion for calculates
     */
    let value: Double

    init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
}
