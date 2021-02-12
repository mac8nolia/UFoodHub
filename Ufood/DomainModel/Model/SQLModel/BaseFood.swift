//
//  BaseFood.swift
//  Ufood
//
//  Created by Ольга on 30.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

class BaseFood {
    
    /**
     Unique id of the food
     */
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    /**
     Name of the food
     */
    lazy var name: String = {
        return SQLManager.shared.getNameOfFood(id: id)
    }()
    
    /**
     Source of data about the food
     */
    lazy var baseSource: String = {
        return SQLManager.shared.getSourceOfFood(id: id)
    }()
    
    /**
     Contained nutrients.
     Key - nutrient's id; value - amount of nutrient for 100 g food's weight
     */
    lazy var nutrients: [Int : Double] = {
        return SQLManager.shared.getNutrientsInFood(id: id)
    }()
    
    /**
     Portions of the food for choice of weight
     */
    lazy var portions: [Portion] = {
        return SQLManager.shared.getPortionsForFood(id: id)
    }()
}
