//
//  TabBarControllerOutput.swift
//  Ufood
//
//  Created by Ольга on 19.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol TabBarControllerOutput {
    
    /**
     Returns number of statistics periods.
     Called for defining number of actions in the action sheet.
     */
    func periodsNumber() -> Int
    
    /**
     Returns name of certain statistics period.
     Called for defining name of each action in the action sheet.
     */
    func periodName(index: Int) -> String
    
    /**
     When user chose period in the action sheet, tab bar controller calls this method.
     Delegate (presenter) must check whether chosen period contains any foods or not, and do callback to controller.
     */
    func periodChosen(index: Int)
}
