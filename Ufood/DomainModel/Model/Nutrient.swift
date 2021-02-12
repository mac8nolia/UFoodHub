//
//  Nutrient.swift
//  Ufood
//
//  Created by Ольга on 19.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

/**
 Nutrients supplied by NutrientProvider to food's and statistics presenters.
 Contains information for presentation and calculates.
 */
class Nutrient {
    
    let id: Int

    let name: String
    
    let unit: String
    
    /**
     Code of nutrients group
     */
    let category: Int
    
    /**
     Reference Daily Intake
     */
    let dailyValue: Double

    /**
     Content of nutrient in different foods (for detail statistics presenter)
     Key - name of unique food; value - amount of nutrient in this food
     */
    var amountInFood = [String : Double]()
    
    lazy var totalAmount: Double = {
        let values = amountInFood.values
        let sum = values.reduce(0, +)
        return sum
    }()

    init(id: Int, name: String, unit: String, category: Int, dailyValue: Double) {
        self.id = id
        self.name = name
        self.unit = unit
        self.category = category
        self.dailyValue = dailyValue
    }
}
