//
//  StatisticsDetailPresenter.swift
//  Ufood
//
//  Created by Ольга on 23.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

class StatisticsDetailPresenter {
    
    private weak var view: StatisticsDetailPresenterOutputView!
    
    /**
     Nutrient for which detail statistics is showing
     */
    private let nutrient: Nutrient
    
    /**
     Foods, in which the nutrient contains, in descending order by amount
     */
    private lazy var foods: [(name: String, amount: Double)] = {
        var resultArray = [(name: String, amount: Double)]()
        for (key,value) in (Array(nutrient.amountInFood).sorted {$0.value > $1.value}) {
            resultArray.append((key,value))
        }
        return resultArray
    }()
    
    init(nutrient: Nutrient) {
        self.nutrient = nutrient
    }
}

// MARK: - Statistics Detail View Output

extension StatisticsDetailPresenter: StatisticsDetailViewOutput {
    
    func set(view: StatisticsDetailPresenterOutputView) {
        self.view = view
    }
    
    func foodsCount() -> Int {
        return foods.count
    }
        
    func configure(cell: StatisticsDetailPresenterOutputCell, indexPath: IndexPath) {
        let food = foods[indexPath.row]
        let name = food.name
        let amount = food.amount
        let amountRounded = amount.rounded(toPlaces: 2)
        let amountWithUnit = String(amountRounded) + " " + nutrient.unit
        cell.showFood(name: name, amount: amountWithUnit)
    }
    
    func getNutrientName() -> String {
        return nutrient.name
    }
    
    func getNutrientTotalAmount() -> String {
        let roundedValue = nutrient.totalAmount.rounded(toPlaces: 2)
        return String(roundedValue) + " " + nutrient.unit
    }
}
