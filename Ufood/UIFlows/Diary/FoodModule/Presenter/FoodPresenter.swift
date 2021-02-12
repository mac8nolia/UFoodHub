//
//  FoodPresenter.swift
//  Ufood
//
//  Created by Ольга on 16.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

class FoodPresenter {
    
    weak var view: FoodPresenterOutputView!
    
    let name: String
    let source: String
    var portionQuantity: Int
    var colorMarker: Int
    
    /**
     Used for different displaying user interface depending on it's add or edit food presenter
     */
    let isAdd: Bool
    
    /**
     Used for getting nutrients groups
     */
    let nutrientProvider: NutrientProvider
    
    init(name: String, source: String, quantity: Int, colorMarker: Int, isAdd: Bool, nutrientProvider: NutrientProvider) {
        self.name = name
        self.source = source
        self.portionQuantity = quantity
        self.colorMarker = colorMarker
        self.isAdd = isAdd
        self.nutrientProvider = nutrientProvider
    }
}

// MARK: - Food View Output

extension FoodPresenter: FoodViewOutput {  
    
    func set(view: FoodPresenterOutputView) {
        self.view = view
    }

    func loadViewData() {
        view.showFoodDetails(name: name, source: source, quantity: String(portionQuantity), colorMarker: colorMarker, addMode: isAdd)
    }
    
    func nutrientsGroupsCount() -> Int {
        return nutrientProvider.nutrientsGroups.count
    }
    
    func nutrientsCountInGroup(index: Int) -> Int {
        return nutrientProvider.nutrientsGroups[index].nutrients.count
    }
    
    func configure(cell: FoodPresenterOutputCell, indexPath: IndexPath) {
        let nutrientsInGroup = nutrientProvider.nutrientsGroups[indexPath.section].nutrients
        let nutrient = nutrientsInGroup[indexPath.row]
        let name = nutrient.name
        
        // Calculate amount of nutrient with considering ratio between portion's quantity and default weight (100 g)
        let amount = nutrient.totalAmount * Double(portionQuantity) / Constants.defaultWeight
        let amountRounded = amount.rounded(toPlaces: 2)
        let amountWithUnit = String(amountRounded) + " " + nutrient.unit
        
        // Calculate daily value ratio between amount of nutrient and daily value norm with converting to procents
        let dailyValueRatio = Int(amount * 100.0 / nutrient.dailyValue) // * 100 %
        let dvRatioWithProcent = String(dailyValueRatio) + " %"
        
        cell.showNutrient(name: name, amount: amountWithUnit, dailyValueRatio: dvRatioWithProcent)
    }
    
    func configure(sectionHeader: FoodPresenterOutputHeader, sectionIndex: Int) {
        let groupName = nutrientProvider.nutrientsGroups[sectionIndex].name
        sectionHeader.showNutrientsGroup(name: groupName)
    }
    
    /**
     Implemented by inheritors
     */
    @objc func doneAction() { }
    
    func colorMarkerChanged(value: Int) {
        colorMarker = value
    }
    
    func quantityChanged(value: Int) {
        portionQuantity = value
        view.redraw()
    }
    
    /**
     Implemented by inheritors
     */
    @objc func quantityHelperAction() { }
}

