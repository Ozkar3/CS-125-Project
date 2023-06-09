//
//  DataController.swift
//  Happy Panda
//
//  Created by Maritza Pott on 6/9/23.
//

import Foundation
import CoreData



class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "FoodModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully.")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func saveFood(name: String, calories: Double) {
        
        let food = FoodTracker(context: container.viewContext)
        food.date = Date()
        food.name = name
        food.calories = calories
        
        
        save(context: container.viewContext)
    }
    
    func getAllFoods() -> [FoodTracker]{
        let fetchrequest: NSFetchRequest<FoodTracker> = FoodTracker.fetchRequest()
        
        do{
            return try container.viewContext.fetch(fetchrequest)
        } catch{
            return []
        }
    }
    

    
    func deleteFood(food: FoodTracker){
        container.viewContext.delete(food)
        do{
            try container.viewContext.save()
        } catch{
            container.viewContext.rollback()
            print("Failed to save")
        }
    }
}
