//
//  CoreDataStack.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 19.07.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private var modelName: String?
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var persistenContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName!)
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("###\(#function): Failed to load persistent stores:\(error)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return persistenContainer.viewContext
    }()
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            }
            catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
