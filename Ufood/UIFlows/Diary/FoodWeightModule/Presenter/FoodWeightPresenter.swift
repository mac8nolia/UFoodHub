//
//  FoodWeightPresenter.swift
//  Ufood
//
//  Created by Ольга on 17.12.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

class FoodWeightPresenter {
    
    private weak var view: FoodWeightPresenterOutput!
    
    /**
     Food's portions from base for user's choice
    */
    private var portions: [Portion]
    
    /**
     Index of current portion.
     By default equal to 0.
     */
    private var currentPortion = 0
    
    /**
     Quantity of portions for user's choice: text - for presence; value - for calculates
     */
    private let quantities: [(text: String, value: Double)] =
        [("1/4",0.25), ("1/2",0.5), ("1",1.0), ("2",2.0), ("3",3.0), ("4",4.0), ("5",5.0),("6",6.0),("7",7.0),("8",8.0),("9",9.0),("10",10.0)]
    
    /**
     Index of current quantity.
     By default quantity of portions = 1.
     */
    private var currentQuantity = 2
    
    init(portions: [Portion]) {
        self.portions = portions
    }
}

// MARK: - Food Weight View Output

extension FoodWeightPresenter: FoodWeightViewOutput { 
    
    var resultingWeight: Int {
        let portion = portions[currentPortion].value
        let number = quantities[currentQuantity].value
        return Int(portion * number)
    }
    
    func set(view: FoodWeightPresenterOutput) {
        self.view = view
    }
    
    func loadViewData() {
        view.showPicker()
        view.showStepperWith(defaultNumber: quantities[currentQuantity].text, maximumValue: Double(quantities.count - 1), currentValue: Double(currentQuantity))
        view.show(resultingWeight: String(resultingWeight)) 
    }
    
    func numberOfComponentsInPicker() -> Int {
        return 1
    }
    
    func numberOfRowsIn(pickerComponent: Int) -> Int {
        return portions.count
    }
    
    func titleFor(row: Int,forPickerComponent component: Int) -> String {
        return portions[row].name
    }
    
    func changed(stepperValue: Int) {
        currentQuantity = stepperValue
        view.change(stepperNumber: quantities[currentQuantity].text)
        view.change(resultingWeight: String(resultingWeight))
    }
    
    func changed(pickerRow: Int) {
        currentPortion = pickerRow
        view.change(resultingWeight: String(resultingWeight))
    }
}

