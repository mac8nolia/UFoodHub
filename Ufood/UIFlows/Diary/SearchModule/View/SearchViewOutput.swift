//
//  SearchViewOutput.swift
//  Ufood
//
//  Created by Ольга on 28.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//

protocol SearchViewOutput {
    
    /**
     After loading view calls this method to pass itself to the presenter for setting
     */
    func set(view: SearchPresenterOutput)
    
    /**
     Returns number of found foods.
     View calls this method to know number of rows.
     */
    func resultsCount() -> Int
    
    /**
     Returns name of each found food.
     View calls this method to know what text to display in each cell.
     */
    func resultName(index: Int) -> String
    
    /**
     When user changes search text in the text field, view calls this method.
     Delegate (presenter) must upgrade searching results and do callback to the view for redraw.
     */
    func change(searchText: String)
    
    /**
     When user selects one of found foods, view calls this method.
     Delegate (presenter) must create food's presenter and do callback to the view for show food's view.
     */
    func showResultDetails(index: Int)
}
