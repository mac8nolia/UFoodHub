//
//  AddBaseFoodPresenter.swift
//  Ufood
//
//  Created by Ольга on 16.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

final class AddBaseFoodPresenter: BaseFoodPresenter {
    
    private var day: Day
    
    init(baseFood: BaseFood, day: Day) {
        self.day = day
        super.init(baseFood: baseFood, quantity: Int(Constants.defaultWeight), colorMarker: 0, isAdd: true) // or "Add to diary"
    }
}

// MARK: - Food View Output

extension AddBaseFoodPresenter {
    
    override func doneAction() {
        CoreDataManager.shared.addListedBaseFood(id: baseFood.id, name: name, quantity: portionQuantity, colorMarker: colorMarker, day: day)
        view.backToDiary()
    }
}
