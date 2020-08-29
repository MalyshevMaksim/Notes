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
    
    lazy var fetchRequestController: NSFetchedResultsController<TextNote> = {
        let fetchRequest: NSFetchRequest<TextNote> = TextNote.fetchRequest()
        let pinnedSortDescriptor = NSSortDescriptor(key: #keyPath(TextNote.isPinned), ascending: false)
        fetchRequest.sortDescriptors = [pinnedSortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: #keyPath(TextNote.section), cacheName: nil)
        performFetch(controller)
        return controller
    }()
    
    lazy var fetchRequestController2: NSFetchedResultsController<PasswordNote> = {
        let fetchRequest: NSFetchRequest<PasswordNote> = PasswordNote.fetchRequest()
        let pinnedSortDescriptor = NSSortDescriptor(key: #keyPath(PasswordNote.isPinned), ascending: false)
        fetchRequest.sortDescriptors = [pinnedSortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: #keyPath(PasswordNote.section), cacheName: nil)
        performFetch2(controller)
        return controller
    }()
    
    private func performFetch(_ controller: NSFetchedResultsController<TextNote>) {
        do {
            try controller.performFetch()
        } catch {
            fatalError("Failed to performFetch: \(error)")
        }
    }
    
    private func performFetch2(_ controller: NSFetchedResultsController<PasswordNote>) {
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

