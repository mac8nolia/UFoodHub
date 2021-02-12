//
//  DatePickerPresenter.swift
//  Ufood
//
//  Created by Ольга on 19.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

class DatePickerPresenter {
    
    private weak var view: DatePickerPresenterOutput!
}

// MARK: - Date Picker View Output

extension DatePickerPresenter: DatePickerViewOutput {
    
    func set(view: DatePickerPresenterOutput) {
        self.view = view
    }
    
    func choseDate(date: Date) {
        if CoreDataManager.shared.checkExist(date: date) {
            view.showExistingDateAlert()
        } else {
            view.returnToDiary()
        }
    }
}
