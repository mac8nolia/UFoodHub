//
//  DiaryViewControllerOutput.swift
//  Ufood
//
//  Created by Ольга on 20.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

protocol DiaryViewOutput {
    
    /**
     Returns number of days in the diary
     View calls this method to know number of sections in the table view.
     */
    func daysCount() -> Int
    
    /**
     Returns number of foods in each day.
     View calls this method to know number of rows in each section.
     */
    func foodsCountInDay(index: Int) -> Int
    
    /**
     View calls this method to fill in each cell with information about appropriate listed food
     */
    func configure(cell: DiaryPresenterOutputCell, indexPath: IndexPath)
    
    /**
     View calls this method to fill in each section's header with information about appropriate day
     */
    func configure(sectionHeader: DiaryPresenterOutputHeader, sectionIndex: Int)
    
    /**
     When user taps to button of adding current day, view calls this method.
     Delegate (presenter) must check whether the day exists in the base or not.
     If not, presenter creates new day in the base and do callback to the view for redraw.
     If yes, presenter do callback to the view for show date's picker for choose another day.
     */
    func addCurrentDay()
    
    /**
     When user chooses the date from date's picker, view calls this method.
     Delegate (presenter) must create new day in base and do callback to the view for redraw.
     */
    func createDay(date: Date)
    
    /**
     When user taps to button of deleting some day from the diary, view calls this method.
     Delegate (presenter) must delete this day from base and do callback to the view for redraw.
     */
    func deleteDay(index: Int)
    
    /**
     When user selects a cell of adding new food to the diary, view calls this method.
     Delegate (presenter) must create search presenter and do callback to the view for show search view.
     */
    func addListedFood(index: Int)
    
    /**
     When user selects a cell with some listed food in the diary, view calls this method.
     Delegate (presenter) must create food's presenter and do callback to the view for show food's view.
     */
    func editListedFood(indexPath: IndexPath)
    
    /**
     When user wants to delete a cell with some listed food from the diary, view calls this method.
     Delegate (presenter) must delete this food from base and do callback to the view for redraw.
     */
    func deleteFood(indexPath: IndexPath)
    
    /**
     Before diary view will appear, it calls this method.
     Delegate (presenter)  must upgrate data and do callback to the view for redraw.
     */
    func upgradeData()
}
