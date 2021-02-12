//
//  CoreDataManager.swift
//  Ufood
//
//  Created by Ольга on 13.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
  
    static let shared = CoreDataManager()
  
    private init() {}
  
    private lazy var persistentContainer: NSPersistentContainer = {
        let modelName = "Ufood"
        var container: NSPersistentContainer!

        if #available(iOS 13.0, *) {
            container = NSPersistentContainer(name: modelName)
        } else {
            // Avoid warning "Failed to load optimized model at path"
            var modelURL = Bundle(for: type(of: self)).url(forResource: modelName, withExtension: "momd")!
            let versionInfoURL = modelURL.appendingPathComponent("VersionInfo.plist")
            if let versionInfoNSDictionary = NSDictionary(contentsOf: versionInfoURL),
                let version = versionInfoNSDictionary.object(forKey: "NSManagedObjectModel_CurrentVersionName") as? String {
                modelURL.appendPathComponent("\(version).mom")
                let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
                container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel!)
            } else {
                // Fall back solution; runs fine despite "Failed to load optimized model" warning
                container = NSPersistentContainer(name: modelName)
            }
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
}
    
//  MARK: - Saving context

extension CoreDataManager {
    
    /**
     Contextual information for handling Core Data context save errors
     */
    enum ContextSaveContextualInfo: String {
        
        case delete = "удалении объекта" // or "deleting object"
        case createDay = "создании нового дня в дневнике" // or "creating new day in the diary"
        case updateListedFood = "обновлении продукта в дневнике" // or "updating food in the diary"
        case addListedFood = "добавлении продукта в дневник" // or "adding food to the diary"
        case commonCase = "попытке доступа" // or "attempting of access"
    }
       
    /**
     Handles save error by presenting an alert
     */
    private func handleSavingError(_ error: Error, contextualInfo: ContextSaveContextualInfo) {
        print("Context saving error: \(error)")
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.delegate?.window,
                  let viewController = window?.rootViewController else { return }
            
            let message = "Ошибка сохранения базы данных при \(contextualInfo.rawValue)" // or "Failed to save the context when "
                    
            //  Append message to existing alert if present
            if let currentAlert = viewController.presentedViewController as? UIAlertController {
                currentAlert.message = (currentAlert.message ?? "") + "\n\n\(message)"
                return
            }
                    
            //  Otherwise present a new alert
            let alert = UIAlertController(title: "Ошибка сохранения базы данных при ", message: message, preferredStyle: .alert) // or "Core Data Saving Error"
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
        }
    }
    
    /**
     Save a context, or handle the save error (for example, when there data inconsistency or low memory)
     */
    func saveContext(with contextualInfo: ContextSaveContextualInfo) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            handleSavingError(error, contextualInfo: contextualInfo)
        }
    }
}
    
//  MARK: - Object provider

extension CoreDataManager {
    
    /**
     Deletes any specified object from the base
     */
    func delete(object: Object) {
        context.delete(object)
        saveContext(with: .delete)
    }
}

// MARK: - Day provider

extension CoreDataManager {
    
    /**
     Creates new day (for food diary)
     */
    func createDay(date: Date) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Day", in: context) else { return }
        let day = Day(entity: entity, insertInto: context)
        
        let year = date.getYear()
        let month = date.getMonth()
        let dayNumber = date.getDayNumber()
        
        day.dayInt = dayNumber
        day.monthInt = month
        day.yearInt = year
        
        saveContext(with: .createDay)
    }
    
    /**
     Returns all days (for load food diary)
     */
    func getAllDays() -> [Day] {
        let request: NSFetchRequest<Day> = Day.fetchRequest()
        request.fetchBatchSize = 20
        
        let sortDescriptorYear = NSSortDescriptor(key: "year", ascending: false)
        let sortDescriptorMonth = NSSortDescriptor(key: "month", ascending: false)
        let sortDescriptorDay = NSSortDescriptor(key: "day", ascending: false)
        request.sortDescriptors = [sortDescriptorYear,sortDescriptorMonth,sortDescriptorDay]
        
        do {
            return try context.fetch(request)
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return [Day]()
    }
    
    /**
     Checks if day with specified date exists (when creating a new day in the diary)
     */
    func checkExist(date: Date) -> Bool {
        if getDay(date: date) != nil {
            return true
        } else {
            return false
        }
    }
    
    /**
     Helped function to get day with specified date
     */
    private func getDay(date: Date) -> Day? {
        let request : NSFetchRequest<Day> = Day.fetchRequest()
        let year = date.getYear()
        let month = date.getMonth()
        let dayNumber = date.getDayNumber()
        
        let firstPredicate = NSPredicate(format: "year = %@", "\(year)")
        let secondPredicate = NSPredicate(format: "month = %@", "\(month)")
        let thirdPredicate = NSPredicate(format: "day = %@", "\(dayNumber)")
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [firstPredicate, secondPredicate,thirdPredicate])
        
        do {
            let day = try context.fetch(request)
            if day.count > 0 {
                return day.first
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return nil
    }
}

//  MARK: - Listed base food provider

extension CoreDataManager {
    
    /**
     Returns foods from day with specified date (for statistics calculates)
     */
    func getListedBaseFoodsWith(date: Date) -> [ListedBaseFood] {
        guard let day = getDay(date: date) else { return [ListedBaseFood]() }
        return day.foods?.array as! [ListedBaseFood]
    }
    
    /**
     Updates color of marker and quantity of portion for specified listed food
     */
    func update(listedBaseFood: ListedBaseFood, colorMarker: Int, portionQuantity: Int) {
        listedBaseFood.colorMarkerInt = colorMarker
        listedBaseFood.portionQuantityInt = portionQuantity
        saveContext(with: .updateListedFood)
    }
    
    /**
     Adds food to specified day in the diary
     */
    func addListedBaseFood(id: Int, name: String, quantity: Int, colorMarker: Int, day: Day) {
        guard let entity = NSEntityDescription.entity(forEntityName: "ListedBaseFood", in: context) else { return }
        let listedBaseFood = ListedBaseFood(entity: entity, insertInto: context)

        listedBaseFood.idInt = id
        listedBaseFood.name = name
        listedBaseFood.portionQuantityInt = quantity
        listedBaseFood.colorMarkerInt = colorMarker

        day.addToFoods(listedBaseFood)
        saveContext(with: .addListedFood)
    }
}
