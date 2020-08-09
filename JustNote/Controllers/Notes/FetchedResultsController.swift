//
//  FetchedResultController.swift
//  JustNote
//
//  Created by Малышев Максим Алексеевич on 8/9/20.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FetchedResultsController {
    lazy var coreDataStack: CoreDataStack = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Failed to get data stack")
        }
        return appDelegate.coreDataStack
    }()
    
    lazy var fetchResultController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let pinnedSortDescriptor = NSSortDescriptor(key: #keyPath(Note.isPinned), ascending: false)
        fetchRequest.sortDescriptors = [pinnedSortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: #keyPath(Note.section), cacheName: nil)
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
}
