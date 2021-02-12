//
//  BaseFoodPresenter.swift
//  Ufood
//
//  Created by Ольга on 16.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

class BaseFoodPresenter: FoodPresenter {
    
    var baseFood: BaseFood
    
    init(baseFood: BaseFood, quantity: Int, colorMarker: Int, isAdd: Bool) {
        self.baseFood = baseFood
        let name = baseFood.name
        let source = baseFood.baseSource
        let nutrientProvider = NutrientProvider(baseFood: baseFood)
        super.init(name: name, source: source, quantity: quantity, colorMarker: colorMarker, isAdd: isAdd, nutrientProvider: nutrientProvider) 
    }
}

// MARK: - Food View Output

extension BaseFoodPresenter {
    
    override func quantityHelperAction() {
        let portions = baseFood.portions
        let foodWeightPresenter = FoodWeightPresenter(portions: portions)
        view.showQuantityHelper(presenter: foodWeightPresenter)
    }
}
