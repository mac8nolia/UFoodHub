//
//  StatisticsDetailViewOutput.swift
//  Ufood
//
//  Created by Ольга on 04.02.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

protocol StatisticsDetailViewOutput {
    
    /**
     After loading view calls this method to pass itself to the presenter for setting
     */
    func set(view: StatisticsDetailPresenterOutputView)
    
    /**
     Returns number of foods in which nutrient contains.
     View calls this method to know number of rows in the foods table.
     */
    func foodsCount() -> Int
    
    /**
     View calls this method to fill in each cell with information about appropriate food
     */
    func configure(cell: StatisticsDetailPresenterOutputCell, indexPath: IndexPath)
    
    /**
     Returns name of the nutrient.
     View calls this method when loads header of table view.
     */
    func getNutrientName() -> String
    
    /**
     Returns total amount of the nutrient.
     View calls this method when loads header of table view.
     */
    func getNutrientTotalAmount() -> String
}
