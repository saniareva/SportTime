//
//  CoreDataManager.swift
//  SportTime
//
//  Created by Alex on 20.05.2021.
//

import CoreData

class CoreDataManager {
    
   static let shared = CoreDataManager()
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SportTime")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


// MARK: - Get Data for CoreDara
extension CoreDataManager {
    
    func getAllExercises() -> [ListExercises] {
        let fetchRequst = NSFetchRequest<ListExercises>(entityName: "ListExercises")
       // let sortedDescription = NSSortDescriptor(key: #keyPath(ListExercises.name), ascending: true)
       // fetchRequst.sortDescriptors = [sortedDescription]
        let context = persistentContainer.viewContext
        
        do {
            let listExercises = try context.fetch(fetchRequst)
            return listExercises
        } catch {
          fatalError("Error = \(error)")
        }
    }
    
    func getExercises(for listExercises: ListExercises) -> [Exercise] {
        let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")
        let predecate = NSPredicate(format: "listExercises == %@", listExercises)
        fetchRequest.predicate = predecate
       // let sortedDescription = NSSortDescriptor(key: #keyPath(Exercise.name), ascending: true)
       // fetchRequest.sortDescriptors = [sortedDescription]
        let context = persistentContainer.viewContext
        
        do {
            let exercises = try context.fetch(fetchRequest)
            return exercises
        } catch {
            fatalError("Error = \(error)")
        }
    }

}

// MARK: Delete from CoreData
extension CoreDataManager {
    
    func deleteListExercises(listExercises: ListExercises) {
        let context = persistentContainer.viewContext
        listExercises.exercise?.forEach({ (exercise) in
            listExercises.removeFromExercise(exercise as! Exercise)
          deleteExersis(exercise: exercise as! Exercise)
        })
        context.delete(listExercises)
        saveContext()
    }
    
    func deleteExersis(exercise: Exercise) {
        let context = persistentContainer.viewContext
        context.delete(exercise)
        saveContext()
    }

}
