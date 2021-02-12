//
//  DateExtensions.swift
//  Ufood
//
//  Created by Ольга on 15.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

extension Date {
    
    /**
     Returns hour value of the date
     */
    func getHour() -> Int {
        let hour = Calendar.current.component(.hour, from: self)
        return hour
    }
    
    /**
     Returns year value of the date
     */
    func getYear() -> Int {
        let year = Calendar.current.component(.year, from: self)
        return year
    }
    
    /**
     Returns month value of the date
     */
    func getMonth() -> Int {
        let month = Calendar.current.component(.month, from: self)
        return month
    }
    
    /**
     Returns day's number value of the date
     */
    func getDayNumber() -> Int {
        let dayNumber = Calendar.current.component(.day, from: self)
        return dayNumber
    }
    
    /**
     Returns date of yesterday
     */
    static var yesterday: Date {
        return Date().dayBefore
    }
    
    /**
     Returns date of the previous day
     */
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self.noon)!
    }
    
    /**
     Returns date for noon time
     */
    private var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    /**
     Returns dates of specified number of previous days
     */
    static func getDatesWith(lastDay: Date, numberOfDays: Int) -> [Date] {
        
        // If number of days equal to 0 - return array with last day
        guard numberOfDays > 0 else { return [lastDay] }
        
        var resultArray = [Date]()
        // Start with last day
        var currentLastDay = lastDay
        for _ in 1...numberOfDays {
            resultArray.append(currentLastDay)
            // Move back in time by one day
            currentLastDay = currentLastDay.dayBefore
        }
        return resultArray
    }
}
