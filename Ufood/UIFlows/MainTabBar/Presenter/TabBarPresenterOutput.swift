//
//  TabBarPresenterOutput.swift
//  Ufood
//
//  Created by Ольга on 19.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol TabBarPresenterOutput: AnyObject {
    
    /**
     When tab bar presenter figures out, that chosen period contains some foods, it calls this method.
     Delegate (tab bar controller) must show statistics view for this period.
     */
    func showStatisticsView()
    
    /**
     When tab bar presenter figures out, that chosen period doesn't contain any foods, it calls this method.
     Delegate (tab bar controller) must show alert about food's absenting
     */
    func showPeriodAlert()
}
