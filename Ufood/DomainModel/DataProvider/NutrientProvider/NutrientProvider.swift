//
//  NutrientProvider.swift
//  Ufood
//
//  Created by Ольга on 17.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

/**
 Created for food or statistics presenter and supply them nutrients for represent
 */
class NutrientProvider {
    
    /**
     Helped objects for getting nutrients
     */
    let foods: [Food]
    
    init(foods: [Food]) {
        self.foods = foods
    }
    
    /**
     Convenience init for base food presenter
     */
    convenience init(baseFood: BaseFood) {
        let name = baseFood.name
        let food = Food(name: name, baseFoods: [(baseFood: baseFood, quantity: Constants.defaultWeight)])
        
        self.init(foods: [food])
    }
    
    /**
     Convenience init for statistics presenter (only base foods)
     */
    convenience init(listedBaseFoods: [ListedBaseFood]) {
        
        // Group base foods with same id
        let groupingBaseFoodById = Dictionary(grouping: listedBaseFoods, by: { $0.idInt })
        
        // Sum portion quantities of each unique food and create helped Food objects
        var foods = [Food]()
        for (id,listedBaseFoods) in groupingBaseFoodById {
            let portionsQuantity = listedBaseFoods.reduce(0) { $0 + $1.portionQuantity }
            let baseFood = BaseFood(id: id)
            let name = baseFood.name
            let food = Food(name: name, baseFoods: [(baseFood: baseFood, quantity: Double(portionsQuantity))])
            foods.append(food)
        }
        
        self.init(foods: foods)
    }
    
    /**
     Returns groups of nutrients for represent
     */
    lazy var nutrientsGroups: [NutrientsGroup] = {
        
        // Loop through all possible nutrients and remain those contained in any of the foods
        // Save in each nutrient information about food wherein nutrient contains, and it's amount in this food
        var nutrients = [Nutrient]()
        let allNutrients = SQLManager.shared.getAllNutrients()
        for nutrient in allNutrients {
            for food in foods {
                guard food.nutrients().keys.contains(nutrient.id) else { continue }
                if let amount = food.nutrients()[nutrient.id] {
                    nutrient.amountInFood[food.name] = amount
                }
            }
            nutrients.append(nutrient)
        }
        
        // Shake off empty nutrients
        nutrients = nutrients.filter { $0.totalAmount > 0}
        
        // Clump nutrients to groups
        // Loop through all possible nutrients groups and create those who contains any nutrient
        var groups = [NutrientsGroup]()
        let groupingNutrientsByCategory = Dictionary(grouping: nutrients, by: { $0.category })
        let allGroups: [(Int,String)] = SQLManager.shared.getAllNutrientsGroups()
        for (category,groupName) in allGroups {
            if let group = groupingNutrientsByCategory[category] {
                let groupForPresent = NutrientsGroup(name: groupName, nutrients: group)
                groups.append(groupForPresent)
            }
        }
        return groups
    }()
}
