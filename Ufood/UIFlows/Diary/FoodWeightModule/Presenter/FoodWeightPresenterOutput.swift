//
//  FoodWeightPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 20.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol FoodWeightPresenterOutput: AnyObject {
    
    /**
     Presenter calls this method when view is loading.
     Delegate (food weight view) must show picker to enable the user to choose some food's portion.
     */
    func showPicker()
    
    /**
     Presenter calls this method when view is loading.
     Delegate (food weight view) must show stepper to enable the user to choose number of quantities of portions.
     */
    func showStepperWith(defaultNumber: String, maximumValue: Double, currentValue: Double)
    
    /**
     Presenter calls this method when view is loading.
     Delegate (food weight view) must show label with resulting weight of food.
     */
    func show(resultingWeight: String)
    
    /**
     When presenter changes current quantity of portions, it calls this method.
     Delegate (food weight view) must change label with quantity.
     */
    func change(stepperNumber: String)
    
    /**
     When presenter changes current portion, it calls this method.
     Delegate (food weight view) must change labels with quantity and with resulting weight.
     */
    func change(resultingWeight: String)
}
