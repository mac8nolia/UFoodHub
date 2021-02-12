//
//  StatisticsDetailPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 04.02.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

import Foundation

protocol StatisticsDetailPresenterOutputCell: AnyObject {
    
    /**
     Presenter calls this method while configures statistics detail view's cells with foods.
     It passes data for appropriate food to the delegate.
     Delegate (statistics detail cell) must show this data.
     */
    func showFood(name: String, amount: String)
}

protocol StatisticsDetailPresenterOutputView: AnyObject { }
