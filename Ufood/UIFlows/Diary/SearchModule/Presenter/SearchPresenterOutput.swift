//
//  SearchPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 28.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol SearchPresenterOutput: AnyObject {
    
    /**
     When presenter upgrades search results, it calls this method.
     Delegate (search view controller) must redraw itself.
     */
    func redraw()
    
    /**
     When presenter creates food presenter (for detail show of found food), it calls this method and pass the presenter.
     Delegate (search view controller) must create and show food view.
     */
    func showFoodViewWith(nextPresenter: FoodPresenter)
}
