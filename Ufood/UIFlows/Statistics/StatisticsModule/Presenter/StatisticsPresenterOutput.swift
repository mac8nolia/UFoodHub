//
//  StatisticsPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 03.02.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol StatisticsPresenterOutputView: AnyObject {
    
    /**
     When presenter upgrades statistics period and its foods, it calls this method.
     Delegate (statistics view) must redraw nutrients table.
     */
    func redraw()
    
    /**
     When presenter upgrades statistics period and its name, it calls this method.
     Delegate (statistics view) must redraw title with new name.
     */
    func set(title: String)
    
    /**
     When presenter creates statistics detail's presenter (for show detail statistics of some selected nutrient), it calls this method and passes created presenter.
     Delegate (statistics view) must create and show statistics detail's view.
     */
    func showDetail(presenter: StatisticsDetailPresenter)
}

protocol StatisticsPresenterOutputCell: AnyObject {
    
    /**
     Presenter calls this method while configures statistics view's cells with nutrients.
     It passes data for appropriate nutrient to the delegate.
     Delegate (statistics cell) must show this data.
     */
    func showNutrient(name: String, dailyValueRatio: Int)
}
