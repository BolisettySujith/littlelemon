//
//  Persistence.swift
//  LittleLemon
//
//  Created by Havells on 18/01/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()


    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LittleLemon")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        // Delete all dishes from the store
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            // Perform the batch delete request
            try container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
            
            // Refresh the viewContext to reflect the changes
            try container.viewContext.save()
            container.viewContext.refreshAllObjects()  // Refresh all objects to reflect changes
            
            print("All dishes cleared successfully")
        } catch {
            print("Failed to clear dishes: \(error)")
        }
    }

}
