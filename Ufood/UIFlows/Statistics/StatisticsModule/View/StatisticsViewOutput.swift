//
//  StatisticsViewOutput.swift
//  Ufood
//
//  Created by Ольга on 03.02.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

protocol StatisticsViewOutput {
    
    /**
     Returns number of nutrients groups.
     View calls this method to know number of sections in the nutrients table.
     */
    func nutrientsGroupsCount() -> Int
    
    /**
     Returns name of each nutrients group.
     View calls this method to know what text to display in each section's header.
     */
    func nameOfNutrientsGroup(index: Int) -> String
    
    /**
     Returns number of nutrients in each group.
     View calls this method to know number of rows in each section in the nutrients table.
     */
    func nutrientsCountInGroup(index: Int) -> Int
    
    /**
     View calls this method to fill in each cell with information about appropriate nutrient
     */
    func configure(cell: StatisticsPresenterOutputCell, indexPath: IndexPath)
    
    /**
     When user selects one of nutrients in the table, view calls this method.
     Delegate (presenter) must create statistics detail's presenter and do callback to the view for show statistics detail's view.
     */
    func showDetailNutrient(indexPath: IndexPath)
}
