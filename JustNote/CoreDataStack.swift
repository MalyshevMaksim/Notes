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
    static var shared = CoreDataStack()
    
    private init() {}
    
    private lazy var persistenContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Note")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load persistent stores:\(error)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return persistenContainer.viewContext
    }()
    
    lazy var fetchRequestController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let pinnedSortDescriptor = NSSortDescriptor(key: #keyPath(Note.isPinned), ascending: false)
        fetchRequest.sortDescriptors = [pinnedSortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: #keyPath(Note.section), cacheName: nil)
        performFetch(controller)
        return controller
    }()
    
    private func performFetch(_ controller: NSFetchedResultsController<Note>) {
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to performFetch: \(error)")
        }
    }
    
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

