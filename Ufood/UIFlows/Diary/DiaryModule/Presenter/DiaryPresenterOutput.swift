//
//  DiaryPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 19.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

protocol DiaryPresenterOutputView: AnyObject {
    
    /**
     When presenter upgrades diary's data, it calls this method.
     Delegate (diary view controller) must redraw itself.
     */
    func redraw()
    
    /**
     When presenter figures out that day with date, chosen by user date, exists in the base, it calls this method.
     Delegate (diary view controller) must show date picker for choose another date.
     */
    func showDatePickerWith(presenter: DatePickerPresenter)
    
    /**
     When presenter creates search presenter (for adding new food), it calls this method and passes the presenter.
     Delegate (diary view controller) must create and show search view.
     */
    func showSearchWith(nextPresenter: SearchPresenter)
    
    /**
     When presenter creates food presenter (for editing existing food), it calls this method and passes the presenter.
     Delegate (diary view controller) must create and show food view.
     */
    func showListedFoodWith(nextPresenter: FoodPresenter)
}

protocol DiaryPresenterOutputCell {
    
    /**
     Presenter calls this method while configures diary view's cells.
     It passes data for appropriate listed foods to delegate.
     Delegate (diary view cell) must show this data.
     */
    func show(name: String, quantity: String, colorMarker: Int)
}

protocol DiaryPresenterOutputHeader {
    
    /**
     Presenter calls this method while configures headers of diary's view.
     It passes the date of appropriate day to the delegate to display it.
     Also it passes the tag for header's identification if user will want to delete day.
     */
    func showDay(date: String, tag: Int)
}
