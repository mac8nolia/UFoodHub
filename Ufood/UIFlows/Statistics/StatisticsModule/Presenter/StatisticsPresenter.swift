//
//  StatisticsPresenter.swift
//  Ufood
//
//  Created by Ольга on 04.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

class StatisticsPresenter {
    
    private weak var view: StatisticsPresenterOutputView!
    
    /**
     Number of days at statistics period, used for calculates of average daily value ratio
     */
    private var numberOfDays: Int!
    
    /**
     Foods at current statistics period.
     When it changes, nutrients provider must be upgrade and view must be redraw. ??????
     */
    private var foodsAtPeriod: [ListedBaseFood]! {
        didSet {
            nutrientProvider = NutrientProvider(listedBaseFoods: foodsAtPeriod)
            view.redraw()
        }
    }
    
    /**
     Name of the current statistics period
     */
    private var periodName: String! {
        didSet {
            view.set(title: periodName)
        }
    }
    
    /**
     Used for getting nutrients groups
     */
    private var nutrientProvider: NutrientProvider?
    
    init(view: StatisticsPresenterOutputView) {
        self.view = view
    }
    
    /**
     After user chose some period for show statistics in the main tab bar module - tab bar presenter calls this function and passed period's parameters
     */
    func changePeriod(name: String, numberOfDays: Int, foods: [ListedBaseFood]) {
        self.periodName = name
        self.numberOfDays = numberOfDays
        self.foodsAtPeriod = foods
    }
}

extension StatisticsPresenter: StatisticsViewOutput {
    
    func nutrientsGroupsCount() -> Int {
        return nutrientProvider?.nutrientsGroups.count ?? 0
    }
        
    func nameOfNutrientsGroup(index: Int) -> String {
        return nutrientProvider?.nutrientsGroups[index].name ?? ""
    }
        
    func nutrientsCountInGroup(index: Int) -> Int {
        return nutrientProvider?.nutrientsGroups[index].nutrients.count ?? 0
    }
        
    func configure(cell: StatisticsPresenterOutputCell, indexPath: IndexPath) {
        if let nutrient = nutrientProvider?.nutrientsGroups[indexPath.section].nutrients[indexPath.row] {
            let name = nutrient.name
            // Calculate average daily value ratio between total amount of nutrient and total norm at period with converting to procents
            let averageDailyValueRatio = Int(nutrient.totalAmount * 100.0 / (nutrient.dailyValue * Double(numberOfDays))) // * 100 %
            cell.showNutrient(name: name, dailyValueRatio: averageDailyValueRatio)
        }
    }
    
    func showDetailNutrient(indexPath: IndexPath) {
        if let nutrient = nutrientProvider?.nutrientsGroups[indexPath.section].nutrients[indexPath.row] {
            let presenter = StatisticsDetailPresenter(nutrient: nutrient)
            view.showDetail(presenter: presenter)
        }
    }
}
