//
//  DatePickerPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 19.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol DatePickerPresenterOutput: AnyObject {
    
    /**
     If presenter figures out that day with chosen date exists in the base, it calls this method.
     Delegate (date picker view) must show alert to user.
     */
    func showExistingDateAlert()
    
    /**
     If presenter figures out that day with chosen date doesn't exist in the base, it calls this method.
     Delegate (date picker view) must return to diary view for next adding the day to diary.
     */
    func returnToDiary()
}
