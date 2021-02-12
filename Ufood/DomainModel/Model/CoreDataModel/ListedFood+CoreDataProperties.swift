//
//  ListedFood+CoreDataProperties.swift
//  Ufood
//
//  Created by Ольга on 29.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//
//

import Foundation
import CoreData

extension ListedFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListedFood> {
        return NSFetchRequest<ListedFood>(entityName: "ListedFood")
    }

    @NSManaged public var colorMarker: Int16
    @NSManaged public var name: String?
    @NSManaged public var portionQuantity: Int16
    @NSManaged public var day: Day?

}

// MARK: - Helped properties for convertation of types

extension ListedFood {
    
    public var colorMarkerInt: Int {
        get { return Int(colorMarker) }
        set { colorMarker = Int16(newValue) }
     }
    
    public var portionQuantityInt: Int {
        get { return Int(portionQuantity) }
        set { portionQuantity = Int16(newValue) }
    }
}
