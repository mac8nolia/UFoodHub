//
//  EditBaseFoodPresenter.swift
//  Ufood
//
//  Created by Ольга on 16.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

final class EditBaseFoodPresenter: BaseFoodPresenter {
    
    var listedBaseFood: ListedBaseFood
    
    init(listedBaseFood: ListedBaseFood) {
        self.listedBaseFood = listedBaseFood
        let baseFood = BaseFood(id: listedBaseFood.idInt)
        super.init(baseFood: baseFood, quantity: listedBaseFood.portionQuantityInt, colorMarker: listedBaseFood.colorMarkerInt, isAdd: false) // or "Upgrade at diary"
    }
} // убрать мэйн баттон

// MARK: - Food View Output

extension EditBaseFoodPresenter {
    
    override func doneAction() {
        CoreDataManager.shared.update(listedBaseFood: listedBaseFood, colorMarker: colorMarker, portionQuantity: portionQuantity)
        view.backToDiary()
    }
}
