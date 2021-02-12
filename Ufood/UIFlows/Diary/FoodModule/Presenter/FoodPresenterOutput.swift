//
//  FoodPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 20.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol FoodPresenterOutputView: AnyObject {
    
    /**
     When presenter upgrades portion quantity of food, it calls this method.
     Delegate (food view) must redraw nutrients table.
     */
    func redraw()
    
    /**
     When presenter gets from view request for loading data, it does callback to the view and passes data to displaying (with this method)
     */
    func showFoodDetails(name: String, source: String, quantity: String, colorMarker: Int, addMode: Bool)
    
    /**
     When presenter adds or edits food, it calls this method.
     Delegate (food view) must return to root (diary) view controller.
     */
    func backToDiary()
    
    /**
     When presenter creates food weight presenter (for help to choose portion quantity), it calls this method and passes the presenter.
     Delegate (food view) must create and show food weight view.
     */
    func showQuantityHelper(presenter: FoodWeightPresenter)
}

protocol FoodPresenterOutputCell {
    
    /**
     Presenter calls this method while configures food view's cells with nutrients.
     It passes data for appropriate nutrient to the delegate.
     Delegate (nutrient cell) must show this data.
     */
    func showNutrient(name: String, amount: String, dailyValueRatio: String)
}

protocol FoodPresenterOutputHeader: AnyObject {
    
    /**
     Presenter calls this method while configures headers of food's view with nutrients groups.
     It passes the name of appropriate group to the delegate to display it.
     */
    func showNutrientsGroup(name: String)
}
