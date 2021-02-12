//
//  TabBarPresenter.swift
//  Ufood
//
//  Created by Ольга on 21.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

enum StatisticsPeriod {
    
    case month
    case week
    case fiveDays
    case threeDays
    case lastDay
    case currentDay

    var info: (number: Int, name: String, numberForStatistics: Int) {
        switch self {
        case .month:
            return (30, "Месяц", 30) // or "Month"
        case .week:
            return (7, "Неделя", 7) // or "Week"
        case .fiveDays:
            return (5,"5 дней", 5) // or "5 days"
        case .threeDays:
            return (3,"3 дня", 3) // or "3 days"
        case .lastDay:
            return (1, "Вчера", 1) // or "Yesterday"
        case .currentDay:
            return (0, "Сегодня", 1) // or "Today"
        }
    }
}

class TabBarPresenter {
    
    private weak var view: TabBarPresenterOutput!
    
    /**
    Presenters for child controllers of tab bar controller
     */
    var childPresenters: [AnyObject]!

    /**
     Statistics periods that provided to user for choice
     */
    private var periods: [StatisticsPeriod] = [.month,.week,.fiveDays,.threeDays,.lastDay,.currentDay]
    
    init(view: TabBarPresenterOutput) {
        self.view = view
    }
}

//MARK: - Tab Bar Controller Output

extension TabBarPresenter: TabBarControllerOutput {
    
    func periodsNumber() -> Int {
        return periods.count
    }
    
    func periodName(index: Int) -> String {
        return periods[index].info.name
    }
    
    func periodChosen(index: Int) {
        let dates = getDatesFor(period: periods[index])
        let foodsAtPeriod = getFoodsAt(dates: dates)
        
        // Check if chosen period contains some foods, then open statistics flow for that period, else show alert about foods absent
        if foodsAtPeriod.count > 0 {
            let statisticsPresenter = childPresenters[Tab.statistics.rawValue] as! StatisticsPresenter
            let periodName = periods[index].info.name
            let numberOfDays = periods[index].info.numberForStatistics
            // Pass to statistics presenter information about chosen period, also foods at this period
            statisticsPresenter.changePeriod(name: periodName, numberOfDays: numberOfDays, foods: foodsAtPeriod)
            view?.showStatisticsView()
        } else {
            view?.showPeriodAlert()
        }
    }
}

//MARK: - Helped functions

extension TabBarPresenter {
    
    /**
     Convert chosen period to array of dates
     */
    func getDatesFor(period: StatisticsPeriod) -> [Date] {
        let today = definePresentDay()
        switch period {
        case .currentDay:
            return [today]
        case .lastDay:
            return [today.dayBefore]
        default:
            let numberOfDays = period.info.number
            return Date.getDatesWith(lastDay: today, numberOfDays: numberOfDays)
        }
    }
    
    /**
     Define present day (today or yesterday) from which to start chosen period
     */
    func definePresentDay() -> Date {
        let currentDate = Date()
        // If current day doesn't contain any foods and present time is less than 6 AM - then present day define as yesterday
        if !CoreDataManager.shared.checkExist(date: currentDate) && (currentDate.getHour() < 6) {
                return Date.yesterday
        } else {
            return currentDate
        }
    }
    
    /**
     Get foods for specified dates (from chosen period) for next check of statistics
     */
    func getFoodsAt(dates: [Date]) -> [ListedBaseFood] {
        var resultArray = [ListedBaseFood]()
        for date in dates {
            resultArray += CoreDataManager.shared.getListedBaseFoodsWith(date: date)
        }
        return resultArray
    }
}
