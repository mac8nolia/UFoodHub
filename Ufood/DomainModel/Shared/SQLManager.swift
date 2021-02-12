//
//  Database.swift
//  Ufood
//
//  Created by Ольга on 10.11.2020.
//  Copyright © 2020 Macnolia. All rights reserved.
//

import Foundation
import SQLite

class SQLManager {
    
    static let shared = SQLManager()
    
    private let connection: Connection?
    
    private init(){
        do {
            let dbPath = Bundle.main.path(forResource: "NutrientsDemo", ofType: "sqlite")!
            connection = try Connection(dbPath)
        } catch {
            connection = nil
            let nserror = error as NSError
            print ("Cannot connect to Database. Error is: \(nserror), \(nserror.userInfo)")
        }
    }
    
    /**
     Possible data sources of food's information.
     Key - code of source from base; value - name of source.
     */
    private let sourceNames: [Int: String] =
        [1: "Скурихин"] // or "Skurihin"
    
    /**
     Keys with names of columns of each table in SQL base
     */
    private enum Key {
        
        case foods(Foods)
        case foodNutrients(FoodNutrients)
        case foodPortions(FoodPortions)
        case nutrients(Nutrients)
        case nutrientsGroups(NutrientsGroups)
        
        enum Foods: String {
            
            static let tableName = "food"
            
            // Columns names
            case id = "fdc_id"
            case source = "base_source"
            case name = "description_rus"
            
            func callAsFunction() -> String {
                return self.rawValue
            }
        }
        
        enum FoodNutrients: String {
            
            static let tableName = "food_nutrient"
            
            // Columns names
            case foodId = "fdc_id"
            case nutrientId = "nutrient_id"
            case amount = "amount"
            
            func callAsFunction() -> String {
                return self.rawValue
            }
        }
        
        enum FoodPortions: String {
            
            static let tableName = "food_portion"
            
            // Columns names:
            case id = "fdc_id"
            case name = "portion_description_rus"
            case weight = "gram_weight"
            
            func callAsFunction() -> String {
                return self.rawValue
            }
        }
        
        enum Nutrients: String {
            
            static let tableName = "nutrients"
            
            // Columns names:
            case id = "nutrient_id"
            case name = "nutrient_name"
            case unit = "unit"
            case dailyValue = "daily_value"
            case groupCategory = "group_category"
            
            func callAsFunction() -> String {
                return self.rawValue
            }
        }
        
        enum NutrientsGroups: String {
            
            static let tableName = "nutrients_groups"
            
            // Columns names
            case category = "group_category"
            case name = "group_name"
            
            func callAsFunction() -> String {
                return self.rawValue
            }
        }
    }
}
    
//  MARK: - BaseFood provider

extension SQLManager {
    
    /**
     Returns name of BaseFood
     */
    func getNameOfFood(id: Int) -> String {
        
        // Check connection with database
        guard let dataBase = connection else {
            return ""
        }
        
        // Create selection options (table and columns)
        let foods = Table(Key.Foods.tableName)
        let foodId = Expression<Int>(Key.Foods.id())
        let name = Expression<String>(Key.Foods.name())
        let filter = foods.filter(id == foodId)
        
        // Execute query and handle results
        var names = [String]()
        do {
            for food in try dataBase.prepare(filter) {
                names.append((food[name]))
            }
        } catch {
            print("SQL prepare failed: \(error)")
        }
        
        if let name = names.first {
            return name
        } else {
            return ""
        }
    }
    
    /**
     Returns name of data source of BaseFood
     */
    func getSourceOfFood(id: Int) -> String {
        
        // Check connection with database
        guard let dataBase = connection else {
            return ""
        }
        
        // Create selection options (table and columns)
        let foods = Table(Key.Foods.tableName)
        let foodId = Expression<Int>(Key.Foods.id())
        let sourceCode = Expression<Int>(Key.Foods.source())
        let filter = foods.filter(id == foodId)
        
        // Execute query and handle results
        var sources = [Int]()
        do {
            for source in try dataBase.prepare(filter) {
                sources.append((source[sourceCode]))
            }
        } catch {
            print("SQL prepare failed: \(error)")
        }
        
        guard let source = sources.first, let name = sourceNames[source] else {
            return ""
        }
        return name
    }
    
    /**
     Returns nutrients of BaseFood
     */
    func getNutrientsInFood(id: Int) -> [Int : Double] {
        
        var resultDictionary = [Int : Double]()
        
        // Check connection with database
        guard let dataBase = connection else {
            return resultDictionary
        }
        
        // Create selection options (table and columns)
        let nutrients = Table(Key.FoodNutrients.tableName)
        let foodId = Expression<Int>(Key.FoodNutrients.foodId())
        let nutrientId = Expression<Int>(Key.FoodNutrients.nutrientId())
        let amount = Expression<Double>(Key.FoodNutrients.amount())
        let filter = nutrients.filter(id == foodId)
        
        // Execute query and handle results
        do {
            for nutrient in try dataBase.prepare(filter) {
                resultDictionary[nutrient[nutrientId]] = nutrient[amount]
            }
        } catch {
            print("SQL prepare failed: \(error)")
        }
        return resultDictionary
    }
    
    /**
     Returns portions of BaseFood
     */
    func getPortionsForFood(id: Int) -> [Portion] {
        
        var resultArray = [Portion]()
        
        // Check connection with database
        guard let dataBase = connection else {
            return resultArray
        }
        
        // Add first portion (100 g) by default
        let defaultPortion = Portion(name: "100 г", value: Constants.defaultWeight) // or "100 g"
        resultArray.append(defaultPortion)
        
        // Create selection options (table and columns)
        let portions = Table(Key.FoodPortions.tableName)
        let foodId = Expression<Int>(Key.FoodPortions.id())
        let description = Expression<String>(Key.FoodPortions.name())
        let gram_weight = Expression<Double>(Key.FoodPortions.weight())
        let filter = portions.filter(id == foodId)
        
        // Execute query and handle results
        do {
            for portion in try dataBase.prepare(filter) {
                let name = portion[description] + " (" + String(portion[gram_weight]) + " г)" // or "g"
                let portion = Portion(name: name, value: portion[gram_weight])
                resultArray.append(portion)
            }
        } catch {
            print("SQL prepare failed: \(error)")
        }
        return resultArray
    }

    /**
     Returns array of BaseFood with names containing search text (for Search module)
     */
    func getFoodsWithName(searchText: String) -> [BaseFood] {
        
        var resultArray = [BaseFood]()
        
        // Check connection with database
        guard let dataBase = connection else {
            return resultArray
        }
        
        // Create selection options (table and columns). Consider case sensitivity
        let foods = Table(Key.Foods.tableName)
        let name = Expression<String>(Key.Foods.name())
        let fdc_id = Expression<Int>(Key.Foods.id())
        let lowerText = searchText.lowercased()
        let capitalizedText = searchText.capitalized
        let filter = foods.filter(name.like("%\(lowerText)%") || name.like("%\(capitalizedText)%"))
        
        // Execute query and handle results
        do {
            for food in try dataBase.prepare(filter) {
                let baseFood = BaseFood(id: food[fdc_id])
                resultArray.append(baseFood)
            }
        } catch {
            print("SQL prepare failed: \(error)")
        }
        return resultArray
    }
}
    
//  MARK: - Nutrients provider

extension SQLManager {
    
    /**
     Returns all nutrients, that could be represent
     */
    func getAllNutrients() -> [Nutrient] {
        var resultArray = [Nutrient]()
        
        // Check connection with database
        guard let dataBase = connection else {
            return resultArray
        }
        
        // Create selection options (table and columns)
        let nutrients = Table(Key.Nutrients.tableName)
        let id = Expression<Int>(Key.Nutrients.id())
        let name = Expression<String>(Key.Nutrients.name())
        let unit = Expression<String>(Key.Nutrients.unit())
        let dailyValue = Expression<Double>(Key.Nutrients.dailyValue())
        let groupCategory = Expression<Int>(Key.Nutrients.groupCategory())
        
        // Execute query and handle results
        do {
            for nutrient in try dataBase.prepare(nutrients) {
                let nutrient = Nutrient(id: nutrient[id], name: nutrient[name], unit: nutrient[unit], category: nutrient[groupCategory], dailyValue: nutrient[dailyValue])
                resultArray.append(nutrient)
            }
        } catch {
            print("SQL prepare failed: \(error)")
        }
        return resultArray
    }
}

//  MARK: - Nutrients groups provider

extension SQLManager {
    
    /**
     Returns all groups of nutrients, that could be represent
     */
    func getAllNutrientsGroups() -> [(Int,String)] {
        var resultArray = [(Int,String)]()
        
        // Check connection with database
        guard let dataBase = connection else {
            return resultArray
        }
        
        // Create selection options (table and columns)
        let groups = Table(Key.NutrientsGroups.tableName)
        let category = Expression<Int>(Key.NutrientsGroups.category())
        let name = Expression<String>(Key.NutrientsGroups.name())
        
        // Execute query and handle results
        do {
            for group in try dataBase.prepare(groups) {
                resultArray.append((group[category],group[name]))
            }
        } catch {
            print("SQL prepare failed: \(error)")
        }
        return resultArray
    }
}

