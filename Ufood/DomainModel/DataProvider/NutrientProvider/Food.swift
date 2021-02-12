//
//  Food.swift
//  Ufood
//
//  Created by Ольга on 17.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

/**
 Represent certain food (base food or custom dish) with function of getting nutrients
 */
struct Food {
    
    let name: String
    
    /**
     Base foods, contained in the Food (if food is custom dish, then there may be a few base foods in the Food)
     */
    let baseFoods: [(baseFood:BaseFood, quantity: Double)]
    
    /**
     Returns set of unique nutrients from base for the food
     */
    func nutrients() -> [Int : Double] {
        var nutrients = [Int : Double]()
        
        for food in baseFoods {
            // Get nutrients from base for default weight (100 g)
            let nutrientsFromBase = food.baseFood.nutrients
            // Calculate quantity of nutrients for specified weight and merge same nutrients
            let resultNutrients = nutrientsFromBase.mapValues {$0 * food.quantity / Constants.defaultWeight }
            nutrients.merge(resultNutrients, uniquingKeysWith: +)
        }
        return nutrients
    }
}
