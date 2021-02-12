//
//  Day+CoreDataProperties.swift
//  Ufood
//
//  Created by Ольга on 29.01.2021.
//  Copyright © 2021 Macnolia. All rights reserved.
//
//

import Foundation
import CoreData

extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var day: Int16
    @NSManaged public var month: Int16
    @NSManaged public var year: Int16
    @NSManaged public var foods: NSOrderedSet?

}

// MARK: - Helped properties for convertation of types

extension Day {
    
    public var dayInt: Int {
        get { return Int(day) }
        set { day = Int16(newValue) }
     }
    
    public var monthInt: Int {
        get { return Int(month) }
        set { month = Int16(newValue) }
    }
    
    public var yearInt: Int {
        get { return Int(year) }
        set { year = Int16(newValue) }
    }
}

// MARK: - Generated accessors for foods

extension Day {

    @objc(insertObject:inFoodsAtIndex:)
    @NSManaged public func insertIntoFoods(_ value: ListedFood, at idx: Int)

    @objc(removeObjectFromFoodsAtIndex:)
    @NSManaged public func removeFromFoods(at idx: Int)

    @objc(insertFoods:atIndexes:)
    @NSManaged public func insertIntoFoods(_ values: [ListedFood], at indexes: NSIndexSet)

    @objc(removeFoodsAtIndexes:)
    @NSManaged public func removeFromFoods(at indexes: NSIndexSet)

    @objc(replaceObjectInFoodsAtIndex:withObject:)
    @NSManaged public func replaceFoods(at idx: Int, with value: ListedFood)

    @objc(replaceFoodsAtIndexes:withFoods:)
    @NSManaged public func replaceFoods(at indexes: NSIndexSet, with values: [ListedFood])

    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: ListedFood)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: ListedFood)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSOrderedSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSOrderedSet)

}
