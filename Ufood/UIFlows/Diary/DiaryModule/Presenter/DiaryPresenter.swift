//
//  DiaryPresenter.swift
//  Ufood
//
//  Created by Ольга on 30.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

class DiaryPresenter: NSObject {
    
    private weak var view: DiaryPresenterOutputView?
    
    /**
     Each day contains unique date and listed foods, which should be represented in the diary view
     */
    private var days: [Day] = [] {
        didSet {
            view?.redraw()
        }
    }
    
    init(view: DiaryPresenterOutputView) {
        self.view = view
    }
}

// MARK: - Diary View Output

extension DiaryPresenter: DiaryViewOutput { 
    
    func upgradeData() {
        days = CoreDataManager.shared.getAllDays()
    }
    
    func deleteDay(index: Int) {
        let day = days[index]
        CoreDataManager.shared.delete(object: day)
        upgradeData()
    }
    
    func daysCount() -> Int {
        return days.count
    }
    
    func foodsCountInDay(index: Int) -> Int {
        return days[index].foods?.count ?? 0 
    }
    
    func configure(cell: DiaryPresenterOutputCell, indexPath: IndexPath) {
        let day = days[indexPath.section]
        guard let foods = day.foods, let listedFood = foods.object(at: indexPath.row) as? ListedFood  else { return }
        let name = listedFood.name ?? ""
        let quantity = String(listedFood.portionQuantity)
        cell.show(name: name, quantity: quantity, colorMarker: listedFood.colorMarkerInt)
    }
    
    func configure(sectionHeader: DiaryPresenterOutputHeader, sectionIndex: Int) {
        let day = days[sectionIndex]
        let dayNumber = String(day.day)
        let monthName = Constants.monthNames[day.monthInt - 1]
        sectionHeader.showDay(date: (dayNumber + " " + monthName), tag: sectionIndex)
    }
    
    func addCurrentDay() {
        if CoreDataManager.shared.checkExist(date: Date()) {
            let presenter = DatePickerPresenter()
            view?.showDatePickerWith(presenter: presenter)
        } else {
            createDay(date: Date())
        }
    }
    
    func createDay(date: Date) {
        CoreDataManager.shared.createDay(date: date)
        upgradeData()
    }
    
    func addListedFood(index: Int) {
        let day = days[index]
        let nextPresenter = SearchPresenter(day: day)
        view?.showSearchWith(nextPresenter: nextPresenter)
    }
    
    func editListedFood(indexPath: IndexPath) {
        let day = days[indexPath.section]
        guard let foods = day.foods, let listedBaseFood = foods.object(at: indexPath.row) as? ListedBaseFood else { return }
        let nextPresenter = EditBaseFoodPresenter(listedBaseFood: listedBaseFood)
        view?.showListedFoodWith(nextPresenter: nextPresenter)
    }
    
    func deleteFood(indexPath: IndexPath) {
        let day = days[indexPath.section]
        guard let foods = day.foods, let listedFood = foods.object(at: indexPath.row) as? ListedBaseFood else { return }
        CoreDataManager.shared.delete(object: listedFood)
        upgradeData()
    }
}

