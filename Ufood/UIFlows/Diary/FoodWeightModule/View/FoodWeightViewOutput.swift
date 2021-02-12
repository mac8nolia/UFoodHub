//
//  FoodWeightViewOutput.swift
//  Ufood
//
//  Created by Ольга on 20.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol FoodWeightViewOutput {
    
    /**
     Returns resulting weigth of food with considering chosen portion and number of portions.
     */
    var resultingWeight: Int { get }
    
    /**
     After loading view calls this method to pass itself to the presenter for setting
     */
    func set(view: FoodWeightPresenterOutput)
    
    /**
     After loading view calls this method to know what data for food weight's choice to display
     */
    func loadViewData()
    
    /**
     Returns 1 by default.
     View calls this method to know number of components in picker of portions.
     */
    func numberOfComponentsInPicker() -> Int
    
    /**
     Returns number of food's portions from base.
     View calls this method to know number of rows in picker of portions.
     */
    func numberOfRowsIn(pickerComponent: Int) -> Int
    
    /**
     Returns name of each portions.
     View calls this method to know title of each row in picker of portions.
     */
    func titleFor(row: Int,forPickerComponent component: Int) -> String
    
    /**
     When user changes quantity of portions in the stepper, view calls this method.
     Delegate (presenter) must calculate new weight and do callback to the view for redraw stepper number's label and resulting weight's label.
     */
    func changed(stepperValue: Int)
    
    /**
     When user pick new row in the portion's picker, view calls this method.
     Delegate (presenter) must calculate new weight and do callback to the view for redraw resulting weight's label.
     */
    func changed(pickerRow: Int)
}
