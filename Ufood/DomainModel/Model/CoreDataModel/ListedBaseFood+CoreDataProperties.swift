//
//  ListedBaseFood+CoreDataProperties.swift
//  Ufood
//
//  Created by Ольга on 29.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//
//

import Foundation
import CoreData

extension ListedBaseFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListedBaseFood> {
        return NSFetchRequest<ListedBaseFood>(entityName: "ListedBaseFood")
    }

    @NSManaged public var id: Int32

}

// MARK: - Helped properties for convertation of types

extension ListedBaseFood {
    
    public var idInt: Int {
        get { return Int(id) }
        set { id = Int32(newValue) }
     }
}
