//
//  DatePickerViewOutput.swift
//  Ufood
//
//  Created by Ольга on 19.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

protocol DatePickerViewOutput {
    
    /**
     When user chooses date in the picker, view calls this method.
     Delegate (presenter) must check whether day with this date exists in the base or not.
     If yes, presenter must do callback to the view for show alert about existing date.
     If no, presenter must do callback to the view for return to diary view and pass the chosen date.
     */
    func choseDate(date: Date)
    
    /**
     After loading view calls this method to pass itself to the presenter for setting
     */
    func set(view: DatePickerPresenterOutput) 
}
