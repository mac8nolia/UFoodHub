//
//  FoodViewOutput.swift
//  Ufood
//
//  Created by Ольга on 20.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

protocol FoodViewOutput {
    
    /**
     After loading view calls this method to pass itself to the presenter for setting
     */
    func set(view: FoodPresenterOutputView)
    
    /**
     After loading view calls this method to know what food's data to display in the table's header (name, quantity, etc )
     */
    func loadViewData()
    
    /**
     Returns number of nutrients groups.
     View calls this method to know number of sections in the nutrients table.
     */
    func nutrientsGroupsCount() -> Int
    
    /**
     Returns number of nutrients in each group.
     View calls this method to know number of rows in each section in the nutrients table.
     */
    func nutrientsCountInGroup(index: Int) -> Int
    
    /**
     View calls this method to fill in each cell with information about appropriate nutrient
     */
    func configure(cell: FoodPresenterOutputCell, indexPath: IndexPath)
    
    /**
     View calls this method to fill in each section's header with information about appropriate group of nutrients
     */
    func configure(sectionHeader: FoodPresenterOutputHeader, sectionIndex: Int)
    
    /**
     When user taps to main button, view calls this method.
     If it add food view, delegate (presenter) must add new food to the base.
     If it edit food view, delegate (presenter) must upgrade existing food in the base.
     */
    func doneAction()
    
    /**
     When user taps to one of color markers, view calls this method.
     Delegate (presenter) must do this marker as current for food.
     */
    func colorMarkerChanged(value: Int)
    
    /**
     When user changes portion's quantity of food in the textfield or chooses portion in the helped view (FoodWeight), view calls this method.
     Delegate (presenter) must upgrade current quantity and do callback to the view for redraw nutrients table.
     */
    func quantityChanged(value: Int)
    
    /**
     When user taps to button of quantity helper, view calls this method.
     Delegate (presenter) must create food weight's presenter and do callback to the view for show food weight's view.
     */
    func quantityHelperAction()
}
