//
//  SearchPresenter.swift
//  Ufood
//
//  Created by Ольга on 04.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation

class SearchPresenter {
    
    private weak var view: SearchPresenterOutput!
    
    /**
     Array with found foods.
     When search text changes, it upgrades and call to the search view for redraw.
     Empty by default.
     */
    private var foods: [BaseFood] = [] {
        didSet {
            view.redraw()
        }
    }
    
    /**
     Stores current day.
     When search presenter creates, it gets current day from diary to pass the day to next presenter (add food presenter), if user will want to add found food to diary.
     */
    private var day: Day
    
    init(day: Day) {
        self.day = day
    }
}

// MARK: - Search view output

extension SearchPresenter: SearchViewOutput {
    
    func set(view: SearchPresenterOutput) {
        self.view = view
    }
    
    func resultsCount() -> Int {
        return foods.count
    }
    
    func resultName(index: Int) -> String {
        let food = foods[index]
        return food.name
    }
    
    func change(searchText: String) {
        if searchText.isEmpty {
            foods = []
        } else {
            foods = SQLManager.shared.getFoodsWithName(searchText: searchText)
        }
    }
    
    func showResultDetails(index: Int) {
        let presenter = AddBaseFoodPresenter(baseFood: foods[index], day: day)
        view.showFoodViewWith(nextPresenter: presenter)
    }
}

